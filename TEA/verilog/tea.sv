//TODO:
//  - Analyze the possibility to use the data register as result one
//  - Analyze the performance of using a 5b count or a 4b count
//  - Cleanup: Use sme register sum to encode and decode
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
    logic [1:0] current_state, next_state;

    //Counter
    logic [4:0] count;
    logic count_en;

    //Aux Signal/Registers
    logic [WORD_SIZE-1:0] k0, k1, k2, k3; //Key
    logic [WORD_SIZE-1:0] v0, v1; //Word
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
            if(count_en == 'h1) begin
                count <= count + 1;
            end
            else begin 
                count <= 0;
            end
        end
    end

    //FSM - Combinational
    always@ (*) begin
        
        case (current_state)
            `IDLE: begin 
                o_ready = 1;
                count_en = 0;
                sum_enc = 0;
                sum_dec = 'hC6EF3720;
                //Assign the values to the aux registers
                v0 = mem_reg['h0];
                v1 = mem_reg['h1];
                k0 = mem_reg['h02];
                k1 = mem_reg['h03];
                k2 = mem_reg['h04];
                k3 = mem_reg['h05];

                case (mem_reg['h06])
                    `CTRL_ENC : next_state = `ENC;
                    `CTRL_DEC : next_state = `DEC;
                    default   : next_state = `IDLE;
                endcase
            end

            `ENC: begin 
                o_ready = 0;
                count_en = 1;
                sum_enc += DELTA;
                v0 += ((v1<<4) + k0) ^ (v1 + sum_enc) ^ ((v1>>5) + k1);
                v1 += ((v0<<4) + k2) ^ (v0 + sum_enc) ^ ((v0>>5) + k3);
                
                if(count >= 'h1F) next_state = `READY;
                else next_state = `ENC;
            end

            `DEC: begin 
                o_ready = 0;
                count_en = 1;
                v1 -= ((v0<<4) + k2) ^ (v0 + sum_dec) ^ ((v0>>5) + k3);
                v0 -= ((v1<<4) + k0) ^ (v1 + sum_dec) ^ ((v1>>5) + k1);
                sum_dec -= DELTA;
                if(count >= 'h1F) next_state = `READY;
                else next_state = `DEC;
            end

            `READY: begin 
                o_ready = 1;
                next_state = `IDLE;
            end

            default : next_state = `IDLE;
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




endmodule