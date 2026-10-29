module tb_cpu;

import cpu_defs::*;

logic clk;
logic reset;

cpu dut (clk, reset);

always #5 clk = ~clk;

  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb_cpu);

    clk = 0;
    reset = 1;

    dut.regfile.registers[1] = 16'd10;
    dut.regfile.registers[2] = 16'd20;
    dut.regfile.registers[3] = 16'd0;
    dut.regfile.registers[5] = 16'd50;
    dut.regfile.registers[6] = 16'd20;
    dut.regfile.registers[4] = 16'd0;

    @(negedge clk);
    reset = 0;

    $display("Simulation started!");

    repeat (4) @(posedge clk);
    @(negedge clk);
    assert(dut.regfile.registers[3] == 16'd0)
        else $fatal(1, "Register 3 should still be zero at the 4th stage.");
    $display("PASS: Register 3 is still zero!");

    @(posedge clk);
    @(negedge clk);
    assert(dut.regfile.registers[3] == 16'd30)
        else $fatal(1, "ADD instruction failed!");
    $display("PASS: ADD instruction passed!");

    @(posedge clk);
    @(negedge clk);
    assert(dut.regfile.registers[4] == 16'd30)
        else $fatal(1, "SUB instruction failed!");
    $display("PASS: SUB instruction passed!");

    @(posedge clk);
    @(negedge clk);
    assert(dut.regfile.registers[3] == 16'd40)
        else $fatal(1, "Second ADD instruction failed!");
    $display("PASS: Second ADD instruction passed!");
    $finish;
  end

endmodule
