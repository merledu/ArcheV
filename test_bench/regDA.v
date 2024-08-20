module RegDA_testbench;

    // Testbench signals
    reg [31:0] pc_in;
    reg [6:0] opcode_in;
    reg [4:0] dest_reg_addr_in;
    reg [2:0] funct3_in;
    reg signed [31:0] src_reg1_data_in;
    reg signed [31:0] src_reg2_data_in;
    reg [4:0] src_reg1_addr_in;
    reg [4:0] src_reg2_addr_in;
    reg [6:0] funct7_in;
    reg signed [31:0] imm_data_in;
    reg [1:0] op1_in;
    reg [1:0] op2_in;
    reg signed [31:0] alu_mem_data_in;
    reg signed [31:0] wb_data_in;
    reg jal_en_in;
    reg jalr_en_in;
    reg forward_op1_in;
    reg forward_op2_in;

    wire [31:0] pc_out;
    wire [6:0] opcode_out;
    wire [4:0] dest_reg_addr_out;
    wire [2:0] funct3_out;
    wire signed [31:0] src_reg1_data_out;
    wire signed [31:0] src_reg2_data_out;
    wire [4:0] src_reg1_addr_out;
    wire [4:0] src_reg2_addr_out;
    wire [6:0] funct7_out;
    wire signed [31:0] imm_data_out;
    wire [1:0] op1_out;
    wire [1:0] op2_out;
    wire jal_en_out;
    wire jalr_en_out;

    // Instantiate the RegDA module
    RegDA uut (
        .pc_in(pc_in),
        .opcode_in(opcode_in),
        .dest_reg_addr_in(dest_reg_addr_in),
        .funct3_in(funct3_in),
        .src_reg1_data_in(src_reg1_data_in),
        .src_reg2_data_in(src_reg2_data_in),
        .src_reg1_addr_in(src_reg1_addr_in),
        .src_reg2_addr_in(src_reg2_addr_in),
        .funct7_in(funct7_in),
        .imm_data_in(imm_data_in),
        .op1_in(op1_in),
        .op2_in(op2_in),
        .alu_mem_data_in(alu_mem_data_in),
        .wb_data_in(wb_data_in),
        .jal_en_in(jal_en_in),
        .jalr_en_in(jalr_en_in),
        .forward_op1_in(forward_op1_in),
        .forward_op2_in(forward_op2_in),

        .pc_out(pc_out),
        .opcode_out(opcode_out),
        .dest_reg_addr_out(dest_reg_addr_out),
        .funct3_out(funct3_out),
        .src_reg1_data_out(src_reg1_data_out),
        .src_reg2_data_out(src_reg2_data_out),
        .src_reg1_addr_out(src_reg1_addr_out),
        .src_reg2_addr_out(src_reg2_addr_out),
        .funct7_out(funct7_out),
        .imm_data_out(imm_data_out),
        .op1_out(op1_out),
        .op2_out(op2_out),
        .jal_en_out(jal_en_out),
        .jalr_en_out(jalr_en_out)
    );

    initial begin
        // Test case 1: No forwarding
        pc_in = 32'h00000004;
        opcode_in = 7'h33;
        dest_reg_addr_in = 5'h01;
        funct3_in = 3'h0;
        src_reg1_data_in = 32'h0000000A; // 10
        src_reg2_data_in = 32'h00000014; // 20
        src_reg1_addr_in = 5'h02;
        src_reg2_addr_in = 5'h03;
        funct7_in = 7'h00;
        imm_data_in = 32'h00000004;      // Immediate value = 4
        op1_in = 2'b00;
        op2_in = 2'b01;
        alu_mem_data_in = 32'h00000000;
        wb_data_in = 32'h00000000;
        jal_en_in = 0;
        jalr_en_in = 0;
        forward_op1_in = 0;
        forward_op2_in = 0;
        #10;

        $display("Test 1 - No Forwarding:");
        $display("PC: %h, Expected: 00000004", pc_out);
        $display("Opcode: %h, Expected: 33", opcode_out);
        $display("Dest Reg Addr: %d, Expected: 1", dest_reg_addr_out);
        $display("Funct3: %d, Expected: 0", funct3_out);
        $display("Src Reg1 Data: %d, Expected: 10", src_reg1_data_out);
        $display("Src Reg2 Data: %d, Expected: 20", src_reg2_data_out);

        // Test case 2: Forwarding from ALU-Memory Pipeline Register to Source Register 1
        forward_op1_in = 1;
        alu_mem_data_in = 32'hFFFFFFF6;   // -10 in two's complement
        #10;

        $display("Test 2 - Forward ALU-Mem to Src1:");
        $display("Src Reg1 Data: %d, Expected: -10", src_reg1_data_out);

        // Test case 3: Forwarding from Write-Back to Source Register 2
        forward_op2_in = 1;
        wb_data_in = 32'h00000014;        // 20
        #10;

        $display("Test 3 - Forward WB to Src2:");
        $display("Src Reg2 Data: %d, Expected: 20", src_reg2_data_out);

        // End simulation
        $finish;
    end

endmodule