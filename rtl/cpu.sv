import cpu_defs::*;

module cpu(
  input logic clk,
  input logic reset, // To be added later
  input logic [15:0] instruction
);

  logic [15:0] alu_a;
  logic [15:0] alu_b;
  logic [15:0] alu_result;

  logic [2:0] rs1; // Source Register #1
  logic [2:0] rs2; // Source Register #2
  logic [2:0] rd;  // Destination Register

  logic        reg_write;
  logic [15:0] write_data;

  logic [3:0] opcode;
  logic [2:0] alu_op;

  logic [15:0] pc; // Program Counter
  logic [15:0] ir; // Instruction Register

  assign ir = instruction;

  assign opcode = ir[15:12];

  assign rs1 = ir[11:9];
  assign rs2 = ir[8:6];
  assign rd = ir[5:3];

  assign write_data = alu_result;

  control_unit cu (
    opcode,
    alu_op,
    reg_write
  );

  register_file regfile (
    .clk(clk),
    .write_en(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .out1(alu_a),
    .out2(alu_b),
    .in(alu_result)
  );

  arithmetic_logic_unit alu (
    .a(alu_a),
    .b(alu_b),
    .op(alu_op),
    .out(alu_result)
  );

endmodule
