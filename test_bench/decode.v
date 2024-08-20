module Decode (
    input [31:0] instruction,   // 32-bit instruction input

    // Outputs
    output [6:0] opcode,        // Opcode (7 bits)
    output [4:0] rd_addr,       // Destination register address (5 bits)
    output [2:0] funct3,        // Function3 (3 bits)
    output [4:0] rs1_addr,      // Source register 1 address (5 bits)
    output [4:0] rs2_addr,      // Source register 2 address (5 bits)
    output [6:0] funct7,        // Function7 (7 bits)
    output signed [31:0] imm_i, // Immediate for I-type (32 bits signed)
    output [6:0] r_id,         // Immediate for R-type (7 bits unsigned)
    output [6:0] i_math_id,    // Immediate for I-type Math (7 bits unsigned)
    output [31:0] i_load_id,   // Immediate for Load instructions (32 bits unsigned)
    output [9:0] i_jalr_id,    // Immediate for JALR (10 bits unsigned)
    output [31:0] s_id,        // Immediate for S-type (32 bits signed)
    output [31:0] b_id,        // Immediate for B-type (32 bits signed)
    output [31:0] u_auipc_id,  // Immediate for AUIPC (32 bits unsigned)
    output [31:0] u_lui_id,    // Immediate for LUI (32 bits unsigned)
    output [31:0] j_id         // Immediate for J-type (32 bits signed)
);

    assign opcode = instruction[6:0];               // Opcode (bits 0-6)
    assign rd_addr = instruction[11:7];             // Destination register address (bits 11-7)
    assign funct3 = instruction[14:12];             // Function3 (bits 14-12)
    assign rs1_addr = instruction[19:15];           // Source register 1 address (bits 19-15)
    assign rs2_addr = instruction[24:20];           // Source register 2 address (bits 24-20)
    assign funct7 = instruction[31:25];             // Function7 (bits 31-25)

    // Immediate value extraction for different types
    assign imm_i = (opcode == 7'b0010011) ? { {20{instruction[31]}}, instruction[31:20] } : 32'b0; // I-type
    assign r_id = (opcode == 7'b0110011) ? instruction[30:24] : 7'b0; // R-type (example condition)
    assign i_math_id = (opcode == 7'b0010011) ? instruction[30:24] : 7'b0; // I-type Math (example condition)
    assign i_load_id = (opcode == 7'b0000011) ? { {20{instruction[31]}}, instruction[31:20] } : 32'b0; // Load (I-type)
    assign i_jalr_id = (opcode == 7'b1100111) ? { {22{instruction[31]}}, instruction[31:20] } : 10'b0; // JALR
    assign s_id = (opcode == 7'b0100011) ? { {20{instruction[31]}}, instruction[31:25], instruction[11:7] } : 32'b0; // S-type
    assign b_id = (opcode == 7'b1100011) ? { {19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 } : 32'b0; // B-type
    assign u_auipc_id = (opcode == 7'b0010111) ? { instruction[31:12], 12'b0 } : 32'b0; // AUIPC (U-type)
    assign u_lui_id = (opcode == 7'b0110111) ? { instruction[31:12], 12'b0 } : 32'b0; // LUI (U-type)
    assign j_id = (opcode == 7'b1101111) ? { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0 } : 32'b0; // J-type

endmodule
