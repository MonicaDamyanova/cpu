module register_file (
  input logic clk,          // Clock
  input logic write_en,     // Write Enable
  input logic [2:0] rs1,    // Source Register 1 - Number designates desired register
  input logic [2:0] rs2,    // Source Register 2
  input logic [2:0] rd,     // Destination Register
  input logic [15:0] in,    // Input data for Destination Register
  output logic [15:0] out1, // Output data from Register 1
  output logic [15:0] out2  // Output data from Register 2
);
  // Will not have a reset

  reg [15:0] registers [1:7];

  // Read
  assign out1 = (rs1 == 0) ? '0 : registers[rs1];
  assign out2 = (rs2 == 0) ? '0 : registers[rs2];

  // Write
  always_ff @(posedge clk) begin 
    if (write_en && rd != 0) begin
      registers[rd] <= in;
    end
  end

endmodule
