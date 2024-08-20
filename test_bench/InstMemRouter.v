module InstMemRouter_testbench;

    // Testbench signals
    reg [15:0] inst_addr_in;
    reg stall_jump;
    reg stall_enable;
    reg [31:0] mem_inst_in;
    reg [31:0] stall_inst_in;

    wire [15:0] inst_addr_out;
    wire [31:0] inst_out;

    // Instantiate the InstMemRouter module
    InstMemRouter uut (
        .inst_addr_in(inst_addr_in),
        .stall_jump(stall_jump),
        .stall_enable(stall_enable),
        .mem_inst_in(mem_inst_in),
        .stall_inst_in(stall_inst_in),
        .inst_addr_out(inst_addr_out),
        .inst_out(inst_out)
    );

    initial begin
        // Test case 1: No stall, no jump
        inst_addr_in = 16'h0040;
        stall_jump = 0;
        stall_enable = 0;
        mem_inst_in = 32'h12345678;
        stall_inst_in = 32'h87654321;
        #10;

        $display("Test 1:");
        $display("Inst Addr Out: %h, Expected: 0040", inst_addr_out);
        $display("Inst Out: %h, Expected: 12345678", inst_out);

        // Test case 2: Stall enabled, no jump
        stall_enable = 1;
        #10;

        $display("Test 2:");
        $display("Inst Addr Out: %h, Expected: 0040", inst_addr_out);
        $display("Inst Out: %h, Expected: 87654321", inst_out);

        // Test case 3: Jump stall detected
        stall_jump = 1;
        stall_enable = 0;
        #10;

        $display("Test 3:");
        $display("Inst Addr Out: %h, Expected: 0040", inst_addr_out);
        $display("Inst Out: %h, Expected: 87654321", inst_out);

        // Test case 4: Both stall and jump enabled
        stall_enable = 1;
        #10;

        $display("Test 4:");
        $display("Inst Addr Out: %h, Expected: 0040", inst_addr_out);
        $display("Inst Out: %h, Expected: 87654321", inst_out);

        
        $finish;
    end

endmodule