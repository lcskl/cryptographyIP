`include "tea.svh"

module tea_apb_wrapper  #(parameter WORD_SIZE=`WORD_SIZE) (
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PRDATA" *)
    output logic [WORD_SIZE-1:0] PRDATA,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PREADY" *)
    output logic                 PREADY,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PSLVERR" *)
    output PSLVERR,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PSEL" *)
    input                        PSEL,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PENABLE" *)
    input                        PENABLE,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PADDR" *)
    input  [            3:0]     PADDR,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PWRITE" *)
    input                        PWRITE,
    //(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PSTRB" *)
    //input  [WORD_SIZE/8-1:0]     PSTRB, //TODO: Implement it if necessary
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 APB_S PWDATA" *)
    input  [WORD_SIZE  -1:0]     PWDATA,
    input                        PRESETn,
    input                        PCLK	
);

    //Aux Signals
    logic we; //Write Enable

    assign PSLVERR = 0;
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