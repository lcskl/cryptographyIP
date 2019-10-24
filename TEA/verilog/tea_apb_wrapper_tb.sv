`include "tea.svh"

module tea_apb_wrapper_tb #(parameter WORD_SIZE=`WORD_SIZE)();
    
    localparam CLK_P = 20;

    logic [WORD_SIZE-1:0]   PRDATA;
    logic                   PREADY;
    logic                   PRESETn;
    logic                   PCLK;
    logic                   PSEL;
    logic                   PENABLE;
    logic [            6:0] PADDR;
    logic                   PWRITE;
    logic                   PSLVERR;
    //logic [WORD_SIZE/8-1:0] PSTRB; //TODO: Implement it if necessary
    logic [WORD_SIZE  -1:0] PWDATA;

    tea_apb_wrapper dut (.*);

    logic [WORD_SIZE-1:0] data_out_pt1, data_out_pt2, control_out;

    initial begin 
        PCLK  = 0;
        PRESETn = 1;
        PADDR = 0;
        PWDATA = 0;
        PENABLE = 0;
        PSEL = 0;

        /*ENCRIPTION*/
        //Reset
        @(negedge PCLK);
        PRESETn = 0;
        @(negedge PCLK);
        PRESETn = 1;
        @(negedge PCLK);
        
        //Load Word
        //First Half
        PADDR = 0;
        PWDATA = 'hBEBACAFE;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //Second Half
        @(negedge PCLK);
        PADDR = 4;
        PWDATA = 'hDEADBEAF;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Load Keys
        //k0
        @(negedge PCLK);
        PADDR = 8;
        PWDATA = 'h00000001;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k1
        @(negedge PCLK);
        PADDR = 12;
        PWDATA = 'h00000002;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k2
        PADDR = 16;
        PWDATA = 'h00000003;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k3
        PADDR = 20;
        PWDATA = 'h00000004;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Control
        @(negedge PCLK);
        PADDR = 24;
        PWDATA = 'h01;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        #(1*CLK_P);
        PWRITE = 0;
        PADDR = 0;
        #(70*CLK_P);
        
        //Read
        //Control
        @(negedge PCLK);
        PADDR = 24;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        control_out = PRDATA;
        //PT1
        @(negedge PCLK);
        PADDR = 28;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out_pt1 = PRDATA;
        //PT2
        @(negedge PCLK);
        PADDR = 32;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out_pt2 = PRDATA;

        /*DECRIPTION*/
        //Reset
        @(negedge PCLK);
        PRESETn = 0;
        @(negedge PCLK);
        PRESETn = 1;
        @(negedge PCLK);
        
        //Load Word
        //First Half
        PADDR = 0;
        PWDATA = data_out_pt1;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //Second Half
        @(negedge PCLK);
        PADDR = 4;
        PWDATA = data_out_pt2;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Load Keys
        //k0
        @(negedge PCLK);
        PADDR = 8;
        PWDATA = 'h00000001;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k1
        @(negedge PCLK);
        PADDR = 12;
        PWDATA = 'h00000002;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k2
        PADDR = 16;
        PWDATA = 'h00000003;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k3
        PADDR = 20;
        PWDATA = 'h00000004;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Control
        @(negedge PCLK);
        PADDR = 24;
        PWDATA = 'h02;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        #(1*CLK_P);
        PWRITE = 0;
        PADDR = 0;
        #(70*CLK_P);
        
        //Read
        //Control
        @(negedge PCLK);
        PADDR = 24;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        control_out = PRDATA;
        //PT1
        @(negedge PCLK);
        PADDR = 28;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out_pt1 = PRDATA;
        //PT2
        @(negedge PCLK);
        PADDR = 32;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out_pt2 = PRDATA;

        $finish;

    end



    always begin 
        #(CLK_P/2) PCLK = ~ PCLK;
    end



endmodule