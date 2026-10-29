import cpu_defs::*;

module cpu(
  input logic clk,
  input logic reset
);
  // Stage 1: Fetch //
  logic [ 7:0] pc;          // Program Counter
  logic [15:0] instruction; // Instruction at the PC address in instruction memory

  instruction_memory inst_mem (
    .address(pc),
    .instruction(instruction) 
  );

  // Stage 2: Decode //
  // Deocode the current instruction in the Instruction Register
  logic [15:0] ir; // Instruction Register
  logic ir_valid;  // Prevents an invalid instruction from writing to registers.

  opcode_t decoded_opcode;
  alu_op_t decoded_alu_op;
  logic    decoded_reg_write;
  logic [2:0] decoded_rs1; // Source Register #1
  logic [2:0] decoded_rs2; // Source Register #2
  logic [2:0] decoded_rd;  // Destination Register
  logic [15:0] decoded_rs1_content;
  logic [15:0] decoded_rs2_content;

  assign decoded_opcode = opcode_t'(ir[15:12]);
  assign decoded_rs1    = ir[11:9];
  assign decoded_rs2    = ir[8:6];
  assign decoded_rd     = ir[5:3];

  control_unit cu (
    .opcode(decoded_opcode),
    .alu_op(decoded_alu_op),
    .reg_write(decoded_reg_write)
  );

  // Stage 3: Execute //
  logic [15:0] alu_a;
  logic [15:0] alu_b;
  logic [15:0] forwarded_alu_a;
  logic [15:0] forwarded_alu_b;
  logic [15:0] alu_result;
  logic [2:0]  executed_rs1;
  logic [2:0]  executed_rs2;
  alu_op_t     executed_alu_op;
  logic [2:0]  executed_rd;        // Carrying over from Stage 2
  logic        executed_reg_write; // Carrying over from Stage 2

  arithmetic_logic_unit alu (
    .a(forwarded_alu_a),
    .b(forwarded_alu_b),
    .op(executed_alu_op),
    .out(alu_result)
  );

  // Stage 4: Memory Access
  // Carrying over from Stage 3
  logic [15:0] memory_alu_result;
  logic [2:0]  memory_rd;
  logic        memory_reg_write;

  // Forwarding results from the ALU before they are written to the
  // register file.
  logic        forward_a;
  logic        forward_b;

  assign forward_a = executed_rs1 == memory_rd &&
                     memory_reg_write &&
                     memory_rd != 0;
  assign forwarded_alu_a = forward_a ? memory_alu_result : alu_a;

  assign forward_b = executed_rs2 == memory_rd &&
                     memory_reg_write &&
                     memory_rd != 0;
  assign forwarded_alu_b = forward_b ? memory_alu_result : alu_b;

  // Stage 5: Writeback
  // Carrying over from Stage 4
  logic [15:0] writeback_alu_result;
  logic [2:0]  writeback_rd;
  logic        writeback_reg_write;

  register_file regfile (
    .clk(clk),
    .rs1(decoded_rs1),
    .rs2(decoded_rs2),
    .out1(decoded_rs1_content),
    .out2(decoded_rs2_content),
    .rd(writeback_rd),
    .in(writeback_alu_result),
    .write_en(writeback_reg_write && !reset) // Prevent writing if reset is set to 1.
  );

  // Always FF is sequential logic (flip-flops)
  // Will not execute automatically, waits for the specific clock edge
  // Only uses non-blocking assignments
  // Non-blocking assignments don't update their destination registers
  // immediately. The right-hand side is evaluated with the values available
  // at the clock edge. The register updates happen afterwards.
  always_ff @(posedge clk) begin
    if (reset) begin 
      pc <= 0;
      ir <= 16'b0;
      ir_valid <= 0;
      executed_reg_write  <= 0;
      memory_reg_write    <= 0;
      writeback_reg_write <= 0;
    end else begin
      // These all happen at the start of each of these stages, and the
      // result is used during the stage.
      // Stage 2: Decode //
      pc <= pc + 1;
      ir <= instruction; // Assumes Asyncronous instruction memory
      ir_valid <= 1;
      // The Instruction Register is automatically decoded into
      // RS1, RS2, RD, and an opcode.

      // Stage 3: Execute //
      alu_a <= decoded_rs1_content;
      alu_b <= decoded_rs2_content;
      executed_rs1 <= decoded_rs1;
      executed_rs2 <= decoded_rs2;
      executed_alu_op <= decoded_alu_op;
      executed_rd <= decoded_rd;
      executed_reg_write <= decoded_reg_write && ir_valid;
      // All of these are either connected to the ALU, or required to
      // write the result back to the Register File in Stage 5.

      // Stage 4: Memory Access //
      memory_alu_result <= alu_result;
      memory_rd <= executed_rd;
      memory_reg_write <= executed_reg_write;
      // No memory access is implemented yet, so these values are just 
      // carried over.

      // Stage 5: Writeback //
      writeback_alu_result <= memory_alu_result;
      writeback_rd <= memory_rd;
      writeback_reg_write <= memory_reg_write;
      // The final value is written to the register file, the writeback 
      // wires are connected directly to the register file.
    end
  end

endmodule
