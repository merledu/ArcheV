module HazardUnit_tb;

    // Testbench signals
    reg [31:0] forward_instr;
    reg [4:0] dest_addr_dec_exec;
    reg [31:0] pc_instr;
    reg [31:0] stall_pc;
    reg [4:0] src1_addr;
    reg [4:0] src2_addr;
    reg load_en;

    wire [31:0] instr_out;
    wire [31:0] pc_instr_out;
    wire [31:0] stall_pc_out;
    wire forward_instr_en;
    wire forward_pc_en;
    wire stall_ctrl_en;

    // Instantiate the HazardUnit module
    HazardUnit uut (
        .forward_instr(forward_instr),
        .dest_addr_dec_exec(dest_addr_dec_exec),
        .pc_instr(pc_instr),
        .stall_pc(stall_pc),
        .src1_addr(src1_addr),
        .src2_addr(src2_addr),
        .load_en(load_en),
        .instr_out(instr_out),
        .pc_instr_out(pc_instr_out),
        .stall_pc_out(stall_pc_out),
        .forward_instr_en(forward_instr_en),
        .forward_pc_en(forward_pc_en),
        .stall_ctrl_en(stall_ctrl_en)
    );

    initial begin
        // Initialize inputs
        forward_instr = 32'hDEADBEEF;
        dest_addr_dec_exec = 5'd10;
        pc_instr = 32'h1000_0000;
        stall_pc = 32'h1000_0100;
        src1_addr = 5'd5;
        src2_addr = 5'd6;
        load_en = 0;

        // Apply test cases
        #10;

        // Test case 1: No load hazard
        $display("Test Case 1: No Load Hazard");
        src1_addr = 5'd8;
        src2_addr = 5'd9;
        load_en = 0;
        #10;
        $display("Instr Out: %h, PC Instr Out: %h, Stall PC Out: %h, Forward Instr En: %b, Forward PC En: %b, Stall Ctrl En: %b",
                 instr_out, pc_instr_out, stall_pc_out, forward_instr_en, forward_pc_en, stall_ctrl_en);

        // Test case 2: Load hazard detected
        $display("Test Case 2: Load Hazard Detected");
        src1_addr = 5'd10;
        src2_addr = 5'd6;
        load_en = 1;
        #10;
        $display("Instr Out: %h, PC Instr Out: %h, Stall PC Out: %h, Forward Instr En: %b, Forward PC En: %b, Stall Ctrl En: %b",
                 instr_out, pc_instr_out, stall_pc_out, forward_instr_en, forward_pc_en, stall_ctrl_en);

        // Test case 3: Load enable but no hazard
        $display("Test Case 3: Load Enable but No Hazard");
        src1_addr = 5'd10;
        src2_addr = 5'd11;
        load_en = 1;
        #10;
        $display("Instr Out: %h, PC Instr Out: %h, Stall PC Out: %h, Forward Instr En: %b, Forward PC En: %b, Stall Ctrl En: %b",
                 instr_out, pc_instr_out, stall_pc_out, forward_instr_en, forward_pc_en, stall_ctrl_en);

        // End simulation
        $finish;
    end

endmodule
