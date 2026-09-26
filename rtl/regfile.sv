module regfile(
  input logic clk;          // Clock
  input logic write_en;     // Write Enable
  input logic [2:0] rs1;    // Source Register 1 - Number designates desired register
  input logic [2:0] rs2;    // Source Register 2
  input logic [2:0] rd;     // Destination Register
  input logic [15:0] in;    // Input data for Destination Register
  output logic [15:0] out1; // Output data from Register 1
  output logic [15:0] out2; // Output data from Register 2
);

  reg [15:0] registers [0:7];

  assign out1 = registers[rs1];
  assign out2 = registers[rs2];

  always_ff @(posedge clk) begin 
    if (write_en) begin
      registers[rd] <= in;
    end
  end

endmodule
