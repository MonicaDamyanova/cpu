//`timescale 1ns/1ps

module tb_alu;

  reg [15:0] a;
  reg [15:0] b;
  reg [1:0] op;

  wire [15:0] out;

  alu dut ( // Device Under Test
    .a(a), .b(b), .op(op), .out(out)
  );

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);

    a = 10;
    b = 20;
    op = 2'b00;
    check_result(30);

    a = 20;
    b = 10;
    op = 2'b01;
    check_result(10);

    $finish;
  end

  task check_result;
    input [15:0] expected;

    begin
      #10;

      if (out != expected)
        $display("FAIL: expected %h, got %h", expected, out);
      else
        $display("PASS");
      end
  endtask

endmodule
