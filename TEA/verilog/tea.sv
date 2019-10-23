//TODO:
//  - Clean Up
//  - Solve decode issue

`include "tea.svh"

module tea #(parameter WORD_SIZE=`WORD_SIZE) (
    output logic [WORD_SIZE-1 :0] o_data,
    output logic o_ready,
    input  logic [WORD_SIZE-1 :0] i_data,
    input  logic [3:0] i_addr,
    input  logic i_we,
    input  logic i_clk,
    input  logic i_rstn
);

    localparam DELTA = 'h9E3779B9;

    //Memory Register
    // 0x00 - Data part 1
    // 0x01 - Data part 2
    // 0x02 - Key part 1
    // 0x03 - Key part 2
    // 0x04 - Key part 3
    // 0x05 - Key part 4
    // 0x06 - Control
    // 0x07 - Result part 1
    // 0x08 - Result part 2

    logic [WORD_SIZE-1:0] mem_reg [`MEM_DEPTH];

    //FSM
    logic [2:0] current_state, next_state;

    //Counter
    logic [6:0] count;
    logic en;

    //Aux Signal/Registers
    logic [WORD_SIZE-1:0] k0, k1, k2, k3; //Key
    logic [WORD_SIZE-1:0] v0, v1; //Word
    logic [WORD_SIZE-1:0] o_v0, o_v1;
    logic [1:0]           enc;
    logic                 load;
    logic                 sel;

    //Sum Encode/Decode Counter
    logic [31:0] sum_enc, sum_dec;

    //Registers Access
    always @(posedge i_clk) begin
        if(~i_rstn) begin
            for (int i = 0; i < `MEM_DEPTH; i++) begin
                mem_reg[i] <= 0;
            end
        end
        else begin
            if(i_we) begin
                if(i_addr != (`MEM_DEPTH-1) && i_addr != (`MEM_DEPTH-2)) begin //No result addr
                    mem_reg[i_addr] <= i_data;
                end
            end
            else begin
                o_data <= mem_reg[i_addr];
            end
            if(next_state == `READY) begin // Is this a good practice?
                mem_reg['h6] <= `CTRL_NONE;
                mem_reg['h7] <= v0;
                mem_reg['h8] <= v1;
            end
        end
    end

    //Counter
    always@ (posedge i_clk) begin 
        if(~i_rstn) begin
            count <= 0;
        end
        else begin
            if(en == 'h1) begin
                count <= count + 1;
            end
            else begin 
                count <= 0;
            end
        end
    end

    //Sum Encode/Decode Counter
    always@ (posedge i_clk) begin 
        if(~i_rstn) begin
            sum_enc <= 'h9E3779B9;
            sum_dec <= 'hC6EF3720;
        end
        else begin
            if(en == 'h1) begin
                if(sel == 'h01) begin
                    sum_enc <= sum_enc + DELTA;
                    sum_dec <= sum_dec - DELTA;
                end
                else begin
                    sum_enc <= sum_enc;
                    sum_dec <= sum_dec;
                end
            end
            else begin 
                sum_enc <= 'h9E3779B9;
                sum_dec <= 'hC6EF3720;
            end
        end
    end

    //FSM - Combinational
    always@ (*) begin
        
        k0 = mem_reg['h02];
        k1 = mem_reg['h03];
        k2 = mem_reg['h04];
        k3 = mem_reg['h05];

        case (current_state)
            `IDLE: begin 
                o_ready = 1;
                en = 0;
                //Assign the values to the aux registers
                //v0 = mem_reg['h0];
                //v1 = mem_reg['h1];
                enc = 'h00;
                load = 'h01;
                sel  = 'h00;

                case (mem_reg['h06])
                    `CTRL_ENC : next_state = `ENC_PT1;
                    `CTRL_DEC : next_state = `DEC_PT1;
                    default   : next_state = `IDLE;
                endcase
            end

            `ENC_PT1: begin 
                o_ready = 0;
                en = 1;
                enc = 'h01;
                load = 'h00;
                sel  = 'h00;
                //v0 += ((v1<<4) + k0) ^ (v1 + sum_enc) ^ ((v1>>5) + k1);
                //v1 += ((v0<<4) + k2) ^ (v0 + sum_enc) ^ ((v0>>5) + k3);
                
                if(count == 'h40) next_state = `READY;
                else next_state = `ENC_PT2;
            end

            `ENC_PT2: begin 
                o_ready = 0;
                en = 1;
                enc = 'h01;
                load = 'h00;
                sel  = 'h01;
                //v0 += ((v1<<4) + k0) ^ (v1 + sum_enc) ^ ((v1>>5) + k1);
                //v1 += ((v0<<4) + k2) ^ (v0 + sum_enc) ^ ((v0>>5) + k3);
                
                if(count == 'h40) next_state = `READY;
                else next_state = `ENC_PT1;
            end

            `DEC_PT1: begin 
                o_ready = 0;
                en = 1;
                enc = 'h02;
                load = 'h00;
                sel  = 'h01;
                //v1 -= ((v0<<4) + k2) ^ (v0 + sum_dec) ^ ((v0>>5) + k3);
                //v0 -= ((v1<<4) + k0) ^ (v1 + sum_dec) ^ ((v1>>5) + k1);
                if(count == 'h40) next_state = `READY;
                else next_state = `DEC_PT2;
            end

            `DEC_PT2: begin 
                o_ready = 0;
                en = 1;
                enc = 'h02;
                load = 'h00;
                sel  = 'h00;
                //v1 -= ((v0<<4) + k2) ^ (v0 + sum_dec) ^ ((v0>>5) + k3);
                //v0 -= ((v1<<4) + k0) ^ (v1 + sum_dec) ^ ((v1>>5) + k1);
                if(count == 'h40) next_state = `READY;
                else next_state = `DEC_PT1;
            end

            `READY: begin 
                o_ready = 1;
                en = 0;
                //v0 = 'h00;
                //v1 = 'h00;
                enc = 'h00;
                load ='h00;
                sel  = 'h00;
                next_state = `IDLE;
            end

            default :  begin 
                o_ready = 1;
                en = 0;
                enc = 'h00;
                load ='h00;
                sel  = 'h00;
                next_state = `IDLE;
            end
        endcase

    end

    //FSM - Sequential
    always @(posedge i_clk) begin
        if(~i_rstn) begin
            current_state <= `IDLE;
        end else begin
            current_state <= next_state;
        end
    end


    always @(posedge i_clk) begin
        if(~i_rstn) begin
            v0 <= 'h00;
            v1 <= 'h00;
        end else begin
            if (load) begin
                v0 <= mem_reg['h0];
                v1 <= mem_reg['h1];
            end
            else begin
                if(sel == 'h00) begin
                    v0 <= o_v0;
                end
                else begin
                    v1 <= o_v1;
                end
            end
        end
    end

    always@(*) begin 
        if(enc == 'h01) begin
            if(sel == 'h00) begin
                o_v0 = v0+(((v1<<4) + k0) ^ (v1 + sum_enc) ^ ((v1>>5) + k1));
                o_v1 = v1;
            end
            else begin
                o_v1 = v1+(((v0<<4) + k2) ^ (v0 + sum_enc) ^ ((v0>>5) + k3));
                o_v0 = v0;
            end
        end
        else if (enc == 'h02) begin 
            if(sel == 'h01) begin
                o_v1 = v1-(((v0<<4) + k2) ^ (v0 + sum_dec) ^ ((v0>>5) + k3));
                o_v0 = v0;
            end
            else begin 
                o_v0 = v0-(((v1<<4) + k0) ^ (v1 + sum_dec) ^ ((v1>>5) + k1));
                o_v1 = v1;
            end
        end
        else begin 
            o_v1 = 'h00;
            o_v0 = 'h00;
        end
    end



endmodule