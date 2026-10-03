module tb_cpu;

logic clk;

cpu dut (clk);

always #5 clk = ~clk;

  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb_cpu);

    clk = 0;

    #10;
    $display("Simulation started!");

    #100;

    $finish;
  end



endmodule
