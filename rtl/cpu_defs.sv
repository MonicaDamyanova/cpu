package cpu_defs;
    // CPU parameters
    parameter DATA_WIDTH = 16;
    parameter INSTR_WIDTH = 16;
    parameter REG_COUNT = 8;

    // Opcodes
    typedef enum logic [3:0] {
        OP_ADD   = 4'h0,
        OP_SUB   = 4'h1,
        OP_AND   = 4'h2,
        OP_OR    = 4'h3,

        OP_LOAD  = 4'h4,
        OP_STORE = 4'h5,

        OP_JMP   = 4'h6,
        OP_BEQ   = 4'h7
    } opcode_t;

    // ALU operations
    typedef enum logic [2:0] {
        ALU_ADD = 3'h0,
        ALU_SUB = 3'h1,
        ALU_AND = 3'h2,
        ALU_OR  = 3'h3
    } alu_op_t;
endpackage
