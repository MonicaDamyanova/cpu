module alu (
  input wire [15:0] a,
  input wire [15:0] b,
  input wire [1:0] op,
  output reg [15:0] out
);

  always @(*) begin
    case (op)
      2'b00: out = a + b;
      2'b01: out = a - b;
      2'b10: out = a & b;
      2'b11: out = a | b;
      default: out = 0;
    endcase
  end

endmodule
