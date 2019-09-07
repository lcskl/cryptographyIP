`include "tea.svh"

module tea_apb_wrapper_tb #(parameter WORD_SIZE=`WORD_SIZE)();
    
    localparam CLK_P = 20;

    logic [WORD_SIZE-1:0]   PRDATA;
    logic                   PREADY;
    logic                   PRESETn;
    logic                   PCLK;
    logic                   PSEL;
    logic                   PENABLE;
    logic [            2:0] PADDR;
    logic                   PWRITE;
    //logic [WORD_SIZE/8-1:0] PSTRB; //TODO: Implement it if necessary
    logic [WORD_SIZE  -1:0] PWDATA;

    tea_apb_wrapper dut (.*);

    logic [WORD_SIZE-1 :0] data_out;

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
        PADDR = 0;
        PWDATA = 'hDEADBEAF_BEBACAFE;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Load Keys
        //k0, k1
        @(negedge PCLK);
        PADDR = 1;
        PWDATA = 'h00000002_00000001;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k2, k3
        PADDR = 2;
        PWDATA = 'h00000004_00000003;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Control
        @(negedge PCLK);
        PADDR = 3;
        PWDATA = 'h01;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        #(34*CLK_P);
        
        //Read
        @(negedge PCLK);
        PADDR = 4;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out = PRDATA;

        /*DECRIPTION*/
        //Reset
        @(negedge PCLK);
        PRESETn = 0;
        @(negedge PCLK);
        PRESETn = 1;
        @(negedge PCLK);
        
        //Load Word
        PADDR = 0;
        PWDATA = data_out;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Load Keys
        //k0, k1
        @(negedge PCLK);
        PADDR = 1;
        PWDATA = 'h00000002_00000001;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        //k2, k3
        PADDR = 2;
        PWDATA = 'h00000004_00000003;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;

        //Control
        @(negedge PCLK);
        PADDR = 3;
        PWDATA = 'h02;
        PSEL   = 1;
        PWRITE = 1;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        #(34*CLK_P);
        
        //Read
        @(negedge PCLK);
        PADDR = 4;
        PSEL   = 1;
        PWRITE = 0;
        @(posedge PCLK);
        PENABLE = 1;
        @(posedge PCLK);
        PENABLE = 0;
        data_out = PRDATA;

        //DEC
        //@(negedge PCLK);
        //PRESETn = 0;
        //@(negedge PCLK);
        //PRESETn = 1;
        //@(negedge PCLK);
        //PADDR = 0;
        //PWDATA = data_out;
        //i_we   = 1;
        //@(negedge PCLK);
        //PADDR = 1;
        //PWDATA = 'h00000002_00000001;
        //i_we   = 1;
        //@(negedge PCLK);
        //PADDR = 2;
        //PWDATA = 'h00000004_00000003;
        //i_we   = 1;
        //@(negedge PCLK);
        //PADDR = 3;
        //PWDATA = 'h02;
        //i_we   = 1;
        //@(negedge PCLK);
        //i_we   = 0;
        //#(34*CLK_P);


        $finish;

    end



    always begin 
        #(CLK_P/2) PCLK = ~ PCLK;
    end



endmodule