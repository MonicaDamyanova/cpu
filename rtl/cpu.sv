module cpu(
  input logic clk
);

  import cpu_defs::*;

  logic [15:0] alu_a;
  logic [15:0] alu_b;
  logic [15:0] alu_result;

  logic [2:0] rs1;
  logic [2:0] rs2;
  logic [2:0] rd;

  logic        reg_write;
  logic [15:0] write_data;

  logic [3:0] opcode;
  logic [1:0] alu_op;

  assign opcode = instruction[15:12];

  assign rs1 = instruction[11:9];
  assign rs2 = instruction[8:6];
  assign rd = instruction[5:3];

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

  alu arithmetic_logic_unit (
    .a(alu_a),
    .b(alu_b),
    .op(alu_op),
    .out(alu_result)
  );

endmodule
