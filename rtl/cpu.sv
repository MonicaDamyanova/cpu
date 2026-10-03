module cpu(
  input logic clk
);

  logic [15:0] alu_a;
  logic [15:0] alu_b;
  logic [15:0] alu_result;

  logic [2:0] rs1;
  logic [2:0] rs2;
  logic [2:0] rd;

  logic        reg_write;
  logic [15:0] write_data;

  logic [1:0] alu_op;

  // Temporary for testing
  assign rs1 = 3'd1;
  assign rs2 = 3'd2;
  assign rd  = 3'd3;

  assign alu_op = 2'b00;

  assign reg_write = 1'b1;
  assign write_data = alu_result;

  regfile register_file (
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
