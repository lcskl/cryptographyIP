//TODO:
//  - Improve the test
//  - Use SV software features

`include "tea.svh"

module tb #(parameter WORD_SIZE=`WORD_SIZE) ();

    localparam CLK_P = 20;

    logic [WORD_SIZE-1 :0] o_data;
    logic o_ready;
    logic [WORD_SIZE-1 :0] i_data;
    logic [2:0] i_addr;
    logic i_we;
    logic i_clk;
    logic i_rstn;

    tea dut (.*);

    logic [WORD_SIZE-1 :0] data_out;

    initial begin 
        i_clk  = 0;
        i_rstn = 1;
        i_addr = 0;
        i_data = 0;
        i_we   = 0;
        //ENC
        @(negedge i_clk);
        i_rstn = 0;
        @(negedge i_clk);
        i_rstn = 1;
        @(negedge i_clk);
        i_addr = 0;
        i_data = 'hDEADBEAF_BEBACAFE;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 1;
        i_data = 'h00000002_00000001;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 2;
        i_data = 'h00000004_00000003;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 3;
        i_data = 'h01;
        i_we   = 1;
        @(negedge i_clk);
        i_we   = 0;
        #(34*CLK_P);
        //Read
        @(negedge i_clk);
        i_addr = 4;
        @(negedge i_clk);
        data_out = o_data;


        //DEC
        @(negedge i_clk);
        i_rstn = 0;
        @(negedge i_clk);
        i_rstn = 1;
        @(negedge i_clk);
        i_addr = 0;
        i_data = data_out;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 1;
        i_data = 'h00000002_00000001;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 2;
        i_data = 'h00000004_00000003;
        i_we   = 1;
        @(negedge i_clk);
        i_addr = 3;
        i_data = 'h02;
        i_we   = 1;
        @(negedge i_clk);
        i_we   = 0;
        #(34*CLK_P);


        $finish;


    end

    always begin 
        #(CLK_P/2) i_clk = ~ i_clk;
    end

endmodule