module RegFD_testbench;

    // Testbench signals
    reg signed [31:0] pc_in;
    reg [31:0] instruction_in;
    reg [31:0] next_pc_in;

    wire signed [31:0] pc_out;
    wire [31:0] instruction_out;
    wire [31:0] next_pc_out;

    // Instantiate the RegFD module
    RegFD uut (
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .next_pc_in(next_pc_in),
        .pc_out(pc_out),
        .instruction_out(instruction_out),
        .next_pc_out(next_pc_out)
    );

    initial begin
        // Test case 1: Initial values
        pc_in = 32'h00000010;              // Program Counter = 16
        instruction_in = 32'hAABBCCDD;     // Example instruction
        next_pc_in = 32'h00000014;         // Next Program Counter = 20
        #10;  // Wait for some time
        
        $display("Test 1:");
        $display("PC: %h, Expected: 00000010", pc_out);
        $display("Instruction: %h, Expected: AABBCCDD", instruction_out);
        $display("Next PC: %h, Expected: 00000014", next_pc_out);

        // Test case 2: Change the input values
        pc_in = 32'hFFFFFFF0;              // Program Counter = -16 (two's complement)
        instruction_in = 32'h12345678;     // Another example instruction
        next_pc_in = 32'h00000000;         // Next Program Counter = 0
        #10;  // Wait for some time
        
        $display("Test 2:");
        $display("PC: %h, Expected: FFFFFFF0", pc_out);
        $display("Instruction: %h, Expected: 12345678", instruction_out);
        $display("Next PC: %h, Expected: 00000000", next_pc_out);

        // End simulation
        $finish;
    end

endmodule