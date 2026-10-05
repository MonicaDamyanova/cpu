module control_unit (
  input  logic [3:0] opcode,

  output alu_op_t alu_op,        // Select ALU operation
  output logic    reg_write,     // Write enable for register file
);

  import cpu_defs::*; 
  
import cpu_defs::*;

module control_unit (
    input  logic [3:0] opcode,

    output alu_op_t alu_op,
    output logic    reg_write
);

  always_comb begin

    alu_op    = ALU_ADD;
    reg_write = 1'b0;

    case (opcode)

      OP_ADD: begin
        alu_op    = ALU_ADD;
        reg_write = 1'b1;
      end

      OP_SUB: begin
        alu_op    = ALU_SUB;
        reg_write = 1'b1;
      end

      OP_AND: begin
        alu_op    = ALU_AND;
        reg_write = 1'b1;
      end

      OP_OR: begin
        alu_op    = ALU_OR;
        reg_write = 1'b1;
      end

      default: begin
        // do nothing
      end

    endcase
  end

 endmodule
