//`timescale 1ns/1ps

import cpu_defs::*;

module tb_alu;

  reg [15:0] a;
  reg [15:0] b;
  alu_op_t op;

  wire [15:0] out;

  arithmetic_logic_unit dut ( // Device Under Test
    .a(a), .b(b), .op(op), .out(out)
  );

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_alu);

    a = 10;
    b = 20;
    op = ALU_ADD;
    check_result(30);

    a = 20;
    b = 10;
    op = ALU_SUB;
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
