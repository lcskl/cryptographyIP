`include "tea.svh"

module tea_apb_wrapper  #(parameter WORD_SIZE=`WORD_SIZE) (
    output logic [WORD_SIZE-1:0] PRDATA,
    output logic                 PREADY,
    input                        PRESETn,
    input                        PCLK,
    input                        PSEL,
    input                        PENABLE,
    input  [            2:0]     PADDR,
    input                        PWRITE,
    //input  [WORD_SIZE/8-1:0]     PSTRB, //TODO: Implement it if necessary
    input  [WORD_SIZE  -1:0]     PWDATA	
);

    //Aux Signals
    logic we; //Write Enable


    assign we = PSEL & PENABLE & PWRITE;

    tea TEA (
        .o_data(PRDATA),
        .o_ready(PREADY),
        .i_data(PWDATA),
        .i_addr(PADDR),
        .i_we(we),
        .i_rstn(PRESETn),
        .i_clk(PCLK)
    );


endmodule