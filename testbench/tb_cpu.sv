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

    @(negedge clk);
    dut.regfile.registers[1] = 16'd10;
    dut.regfile.registers[2] = 16'd20;
    dut.regfile.registers[3] = 16'd30;
    dut.regfile.registers[4] = 16'd40;

    @(posedge clk);
    #1;
    reset = 0;
    $display("Simulation started!");

    assert(dut.regfile.registers[3] == 16'd30)
        else $fatal(1, "ADD instruction failed!");
    $display("ADD instruction passed!");

    #100;

    $finish;
  end

endmodule
