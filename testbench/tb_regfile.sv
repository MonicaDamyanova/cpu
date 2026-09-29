module tb_regfile;

  logic clk;
  logic write_en;
  logic [2:0] rs1;
  logic [2:0] rs2;
  logic [2:0] rd;
  logic [15:0] in;
  logic [15:0] out1;
  logic [15:0] out2;

  regfile dut (clk, write_en, rs1, rs2, rd, in, out1, out2);

  always #5 clk = ~clk;

  initial begin
    $dumpfile("regfile.vcd");
    $dumpvars(0, tb_regfile);

    // Write to Register 3
    @(negedge clk);
    write_en = 1;
    rd = 3;
    in = 16'd10;

    // Stop writing
    @(negedge clk);
    write_en = 0;

    // Read Register 3
    rs1 = 3;

    #1;

    if (out1 != 16'd10)
      $display("FAIL: R1");
    else
      $display("PASS");

    $finish;
  end

endmodule
