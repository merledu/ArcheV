module RegFile_tb;

    // Testbench signals
    reg [4:0] dest_addr;
    reg [31:0] dest_data;
    reg [4:0] src1_addr;
    reg [4:0] src2_addr;
    reg write_enable;

    wire [31:0] src1_data;
    wire [31:0] src2_data;

    // Instantiate the RegFile module
    RegFile uut (
        .dest_addr(dest_addr),
        .dest_data(dest_data),
        .src1_addr(src1_addr),
        .src2_addr(src2_addr),
        .write_enable(write_enable),
        .src1_data(src1_data),
        .src2_data(src2_data)
    );

    initial begin
        // Initialize inputs
        dest_addr = 5'd0;
        dest_data = 32'h0;
        src1_addr = 5'd0;
        src2_addr = 5'd0;
        write_enable = 0;

        // Apply test cases
        #10;

        // Test case 1: Write data to register and read from it
        $display("Test Case 1: Write and Read");
        dest_addr = 5'd5;
        dest_data = 32'hA5A5A5A5;
        write_enable = 1;
        #10;

        src1_addr = 5'd5;
        src2_addr = 5'd0; // Zero address should read 0
        #10;
        $display("src1_data: %h, src2_data: %h", src1_data, src2_data);

        // Test case 2: Write enable is off, data should not be written
        $display("Test Case 2: Write Enable Off");
        write_enable = 0;
        dest_addr = 5'd10;
        dest_data = 32'hDEADBEEF;
        #10;

        src1_addr = 5'd5; // Should still be A5A5A5A5
        src2_addr = 5'd10; // Should be 0 because write_enable is off
        #10;
        $display("src1_data: %h, src2_data: %h", src1_data, src2_data);

        // Test case 3: Write to zero address, should not affect register file
        $display("Test Case 3: Write to Zero Address");
        write_enable = 1;
        dest_addr = 5'd0; // Zero address, should not change any data
        dest_data = 32'h12345678;
        #10;

        src1_addr = 5'd5; // Should still be A5A5A5A5
        src2_addr = 5'd10; // Should still be 0
        #10;
        $display("src1_data: %h, src2_data: %h", src1_data, src2_data);

        // End simulation
        $finish;
    end

endmodule
