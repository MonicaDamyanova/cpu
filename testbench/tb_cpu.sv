module tb_cpu;

import cpu_defs::*;

logic clk;
logic reset;
logic [15:0] instruction;

cpu dut (clk, reset, instruction);

always #5 clk = ~clk;

  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb_cpu);

    clk = 0;
    reset = 1;
    instruction = 16'b0;
    
    @(negedge clk);
    dut.regfile.registers[1] = 16'd10;
    dut.regfile.registers[2] = 16'd20;

    instruction = {
      OP_ADD,
      3'd1,       // rs1
      3'd2,       // rs2
      3'd3,       // rd
      3'b000
    };

    @(posedge clk);
    #1;
    $display("Simulation started!");

    assert(dut.regfile.registers[3] == 16'd30)
        else $fatal(1, "ADD instruction failed!");
    $display("ADD instruction passed!");

    #100;

    $finish;
  end

endmodule
