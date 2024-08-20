module Fetch_testbench;

    // Testbench signals
    reg forward_inst_en;
    reg forward_pc_en;
    reg br_instr;
    reg jal_instr;
    reg jalr_instr;

    reg [31:0] pc_in;
    reg [31:0] next_pc_in;
    reg [31:0] jalr_pc_in;
    reg [31:0] inst_in;
    reg [31:0] fd_pc_in;
    reg signed [31:0] imm_val_in;

    wire [31:0] pc_out;
    wire [31:0] pc_plus_4_out;
    wire [31:0] next_pc_out;
    wire [15:0] inst_mem_addr_out;

    // Instantiate the Fetch module
    Fetch uut (
        .forward_inst_en(forward_inst_en),
        .forward_pc_en(forward_pc_en),
        .br_instr(br_instr),
        .jal_instr(jal_instr),
        .jalr_instr(jalr_instr),
        .pc_in(pc_in),
        .next_pc_in(next_pc_in),
        .jalr_pc_in(jalr_pc_in),
        .inst_in(inst_in),
        .fd_pc_in(fd_pc_in),
        .imm_val_in(imm_val_in),
        .pc_out(pc_out),
        .pc_plus_4_out(pc_plus_4_out),
        .next_pc_out(next_pc_out),
        .inst_mem_addr_out(inst_mem_addr_out)
    );

    initial begin
        // Test case 1: No forwarding, no branch, jal, or jalr
        forward_inst_en = 0;
        forward_pc_en = 0;
        br_instr = 0;
        jal_instr = 0;
        jalr_instr = 0;
        pc_in = 32'h00000008;
        next_pc_in = 32'h0000000C;
        jalr_pc_in = 32'h00000010;
        inst_in = 32'h12345678;
        fd_pc_in = 32'h00000004;
        imm_val_in = 32'sd4;
        #10;

        $display("Test 1:");
        $display("PC: %h, Expected: 00000008", pc_out);
        $display("PC + 4: %h, Expected: 0000000C", pc_plus_4_out);
        $display("Next PC: %h, Expected: 0000000C", next_pc_out);
        $display("Instruction Memory Address: %h, Expected: 00000008", inst_mem_addr_out);

        // Test case 2: Forwarding enabled
        forward_inst_en = 1;
        forward_pc_en = 1;
        #10;

        $display("Test 2:");
        $display("PC: %h, Expected: 00000008", pc_out);
        $display("PC + 4: %h, Expected: 0000000C", pc_plus_4_out);
        $display("Next PC: %h, Expected: 0000000C", next_pc_out);
        $display("Instruction Memory Address: %h, Expected: 00000008", inst_mem_addr_out);

        // Test case 3: JAL instruction
        forward_inst_en = 0;
        forward_pc_en = 0;
        jal_instr = 1;
        #10;

        $display("Test 3:");
        $display("PC: %h, Expected: 00000008", pc_out);
        $display("PC + 4: %h, Expected: 0000000C", pc_plus_4_out);
        $display("Next PC: %h, Expected: 0000000C", next_pc_out);
        $display("Instruction Memory Address: %h, Expected: 00000008", inst_mem_addr_out);

        // Test case 4: JALR instruction
        jal_instr = 0;
        jalr_instr = 1;
        #10;

        $display("Test 4:");
        $display("PC: %h, Expected: 00000010", pc_out);
        $display("PC + 4: %h, Expected: 00000014", pc_plus_4_out);
        $display("Next PC: %h, Expected: 00000010", next_pc_out);
        $display("Instruction Memory Address: %h, Expected: 00000010", inst_mem_addr_out);

        // End simulation
        $finish;
    end

endmodule