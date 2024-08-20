module Jumpunit (
    // Inputs
    input signed [31:0] src1_data,           // Source register 1 data
    input signed [31:0] src2_data,           // Source register 2 data
    input signed [31:0] alu_result,          // ALU result
    input signed [31:0] regam_alu_out,       // ALU result from RegAM
    input signed [31:0] write_back,          // Write-back data
    input signed [31:0] mem_data_out,        // Memory data output
    input [2:0] funct3,                      // Function3 field
    input [6:0] branch_id,                   // Branch ID
    input [9:0] i_jal_id,                   // JAL ID
    input [6:0] opcode,                      // Opcode
    input [2:0] forward_jump_operand1,       // Forward jump operand 1
    input [2:0] forward_jump_operand2,       // Forward jump operand 2
    input signed [31:0] immediate_instr,     // Immediate instruction value

    // Outputs
    output reg [31:0] jalr_pc,              // JALR PC target address
    output reg branch_enable,                // Branch enable
    output reg b_enable,                     // Branch enable signal
    output reg jal_enable,                  // JAL enable signal
    output reg jalr_enable,                 // JALR enable signal
    output reg jalr_pc_enable               // JALR PC enable signal
);

    
    wire branch_taken;
    wire [31:0] target_address;
    wire [31:0] jalr_target_address;
    reg [31:0] pc_plus_4;  // PC + 4 for branch calculations

    // Compute PC + 4
    always @(*) begin
        pc_plus_4 = alu_result + 4;
    end

    // Compute JALR target address
    always @(*) begin
        jalr_target_address = src1_data + immediate_instr;
        jalr_pc = jalr_target_address;
    end

    // Compute branch taken
    always @(*) begin
        case (funct3)
            3'b000: branch_taken = (src1_data == src2_data);    // BEQ
            3'b001: branch_taken = (src1_data != src2_data);    // BNE
            3'b100: branch_taken = ($signed(src1_data) < $signed(src2_data));  // BLT
            3'b101: branch_taken = ($signed(src1_data) >= $signed(src2_data)); // BGE
            3'b110: branch_taken = ($unsigned(src1_data) < $unsigned(src2_data)); // BLTU
            3'b111: branch_taken = ($unsigned(src1_data) >= $unsigned(src2_data)); // BGEU
            default: branch_taken = 1'b0;
        endcase
    end

    // Determine control signals
    always @(*) begin
        // Default values
        branch_enable = 0;
        b_enable = 0;
        jal_enable = 0;
        jalr_enable = 0;
        jalr_pc_enable = 0;

        // Branch enable
        if (branch_taken) begin
            branch_enable = 1;
            b_enable = 1;
        end

        // JAL enable
        if (opcode == 7'b1101111) begin
            jal_enable = 1;
        end

        // JALR enable
        if (opcode == 7'b1100111) begin
            jalr_enable = 1;
            jalr_pc_enable = 1;
        end
    end

endmodule
