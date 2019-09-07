//Configuration
`define WORD_SIZE 64
`define MEM_DEPTH 5 

//Control Values
`define CTRL_NONE 'b00
`define CTRL_ENC  'b01
`define CTRL_DEC  'b10

//FSM States
`define IDLE  'b00
`define ENC   'b01
`define DEC   'b10
`define READY 'b11