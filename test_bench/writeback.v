module writeback_testbench;

    // Testbench signals
    reg signed [31:0] alu_result;
    reg signed [31:0] mem_data;
    reg load_data_sel;
    wire signed [31:0] wb_data;

    // Instantiate the writeback module
    writeback uut (
        .alu_result(alu_result),
        .mem_data(mem_data),
        .load_data_sel(load_data_sel),
        .wb_data(wb_data)
    );

    initial begin
        // Test case 1: load_data_sel = 0, alu_result should be selected
        alu_result = 32'h0000000A;  // ALU result = 10
        mem_data = 32'h00000064;    // Memory data = 100
        load_data_sel = 0;          // Select ALU result
        #10;
        $display("Test 1 - Expected: 10, Actual: %d", wb_data);

        // Test case 2: load_data_sel = 1, mem_data should be selected
        load_data_sel = 1;          // Select memory data
        #10;
        $display("Test 2 - Expected: 100, Actual: %d", wb_data);

        // Test case 3: change ALU result and load_data_sel = 0
        alu_result = 32'hFFFFFFF6;  // ALU result = -10 (two's complement)
        load_data_sel = 0;          // Select ALU result
        #10;
        $display("Test 3 - Expected: -10, Actual: %d", wb_data);

        // Test case 4: change memory data and load_data_sel = 1
        mem_data = 32'hFFFFFF9C;    // Memory data = -100 (two's complement)
        load_data_sel = 1;          // Select memory data
        #10;
        $display("Test 4 - Expected: -100, Actual: %d", wb_data);

        // End simulation
        $finish;
    end

endmodule
