module ALU_testbench;

    // Testbench signals
    reg [31:0] pc_in;
    reg signed [31:0] src1_data;
    reg signed [31:0] src2_data;
    reg signed [31:0] imm_val;

    reg imm_sel;
    reg add_en;
    reg sll_en;
    reg slt_en;
    reg xor_en;
    reg srl_en;
    reg sra_en;
    reg or_en;
    reg and_en;
    reg sub_en;
    reg jalr_en;
    reg jal_en;
    reg auipc_en;
    reg lui_en;

    wire signed [31:0] result_out;

    // Instantiate the ALU module
    ALU uut (
        .pc_in(pc_in),
        .src1_data(src1_data),
        .src2_data(src2_data),
        .imm_val(imm_val),
        .imm_sel(imm_sel),
        .add_en(add_en),
        .sll_en(sll_en),
        .slt_en(slt_en),
        .xor_en(xor_en),
        .srl_en(srl_en),
        .sra_en(sra_en),
        .or_en(or_en),
        .and_en(and_en),
        .sub_en(sub_en),
        .jalr_en(jalr_en),
        .jal_en(jal_en),
        .auipc_en(auipc_en),
        .lui_en(lui_en),
        .result_out(result_out)
    );

    initial begin
        // Test case 1: Addition operation
        pc_in = 32'h00000010;
        src1_data = 32'sd20;
        src2_data = 32'sd15;
        imm_val = 32'SD5;
        imm_sel = 0;
        add_en = 1;
        sub_en = 0;
        and_en = 0;
        or_en = 0;
        xor_en = 0;
        sll_en = 0;
        srl_en = 0;
        sra_en = 0;
        slt_en = 0;
        jalr_en = 0;
        jal_en = 0;
        auipc_en = 0;
        lui_en = 0;
        #10;
        $display("Addition Result: %d, Expected: 35", result_out);

        // Test case 2: Subtraction operation
        add_en = 0;
        sub_en = 1;
        #10;
        $display("Subtraction Result: %d, Expected: 5", result_out);

        // Test case 3: AND operation
        sub_en = 0;
        and_en = 1;
        #10;
        $display("AND Result: %d, Expected: 4", result_out);

        // Test case 4: OR operation
        and_en = 0;
        or_en = 1;
        #10;
        $display("OR Result: %d, Expected: 31", result_out);

        // Test case 5: XOR operation
        or_en = 0;
        xor_en = 1;
        #10;
        $display("XOR Result: %d, Expected: 27", result_out);

        // Test case 6: Shift Left Logical operation
        xor_en = 0;
        sll_en = 1;
        #10;
        $display("SLL Result: %d, Expected: 480", result_out);

        // Test case 7: Shift Right Logical operation
        sll_en = 0;
        srl_en = 1;
        #10;
        $display("SRL Result: %d, Expected: 1", result_out);

        // Test case 8: Shift Right Arithmetic operation
        srl_en = 0;
        sra_en = 1;
        src1_data = -32'sd32;
        #10;
        $display("SRA Result: %d, Expected: -1", result_out);

        // Test case 9: Less Than operation
        sra_en = 0;
        slt_en = 1;
        src1_data = 32'sd10;
        src2_data = 32'sd20;
        #10;
        $display("SLT Result: %d, Expected: 1", result_out);

        // Test case 10: Program Counter + 4
        slt_en = 0;
        jalr_en = 0;
        jal_en = 0;
        auipc_en = 0;
        lui_en = 0;
        #10;
        $display("PC + 4 Result: %d, Expected: 20", result_out);

        // Test case 11: AUIPC operation
        auipc_en = 1;
        imm_val = 32'sd1;
        #10;
        $display("AUIPC Result: %d, Expected: 4096", result_out);

        // Test case 12: LUI operation
        auipc_en = 0;
        lui_en = 1;
        imm_val = 32'sd1;
        #10;
        $display("LUI Result: %d, Expected: 4096", result_out);

        // End simulation
        $finish;
    end

endmodule