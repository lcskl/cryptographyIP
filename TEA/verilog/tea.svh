//Configuration
`define WORD_SIZE 32
`define MEM_DEPTH 9 

//Control Values
`define CTRL_NONE 'b00
`define CTRL_ENC  'b01
`define CTRL_DEC  'b10

//FSM States
`define IDLE    'b000
`define ENC_PT1 'b001
`define ENC_PT2 'b010
`define DEC_PT1 'b011
`define DEC_PT2 'b100
`define READY   'b101