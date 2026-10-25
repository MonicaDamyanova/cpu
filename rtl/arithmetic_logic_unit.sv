import cpu_defs::*;

module arithmetic_logic_unit (
  input wire [15:0] a,
  input wire [15:0] b,
  input alu_op_t  op,
  output reg [15:0] out
);

  always @(*) begin
    case (op)
      ALU_ADD: out = a + b;
      ALU_SUB: out = a - b;
      ALU_AND: out = a & b;
      ALU_OR: out = a | b;
      default: out = 0;
    endcase
  end

endmodule
