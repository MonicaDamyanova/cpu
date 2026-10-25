import cpu_defs::*;

module tb_control_unit;

  opcode_t opcode;
  alu_op_t alu_op;
  logic reg_write; 

  control_unit dut (opcode, alu_op, reg_write); 

  initial begin
    $dumpfile("control_unit.vcd");
    $dumpvars(0, tb_control_unit);

    opcode = OP_ADD;
    check_result(ALU_ADD, 1);

    opcode = OP_SUB;
    check_result(ALU_SUB, 1);

    opcode = OP_AND;
    check_result(ALU_AND, 1);

    opcode = OP_OR;
    check_result(ALU_OR, 1);

    $finish;
  end

  task check_result;
    input alu_op_t expected_alu_op;
    input logic expected_reg_write;

    begin
      #10;

      if (alu_op != expected_alu_op)
        $display("FAIL: expected %h, got %h", expected_alu_op, alu_op);
      else if (reg_write != expected_reg_write)
        $display("FAIL: expected %h, got %h", expected_reg_write, reg_write);
      else
        $display("PASS");
      end
  endtask
endmodule
