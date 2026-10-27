// Temporary until I have proper memory implemented.

module instruction_memory (
  input  logic [7:0] address,
  output logic [15:0] instruction
);

  logic [15:0] memory [0:255];

  initial begin
    $readmemb("program.mem", memory);
  end

  assign instruction = memory[address];

endmodule
