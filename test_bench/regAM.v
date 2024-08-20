module RegAM_testbench;

    // Testbench signals
    reg signed [31:0] alu_result_in;
    reg [4:0] dest_addr_in;
    reg signed [31:0] src2_data_in;
    reg reg_write_en_in;
    reg data_mem_store_en_in;
    reg store_byte_en_in;
    reg store_half_en_in;
    reg store_word_en_in;
    reg data_mem_load_en_in;
    reg load_byte_en_in;
    reg load_half_en_in;
    reg load_word_en_in;
    reg load_byte_unsign_en_in;
    reg load_half_unsign_en_in;

    wire signed [31:0] alu_result_out;
    wire [4:0] dest_addr_out;
    wire signed [31:0] src2_data_out;
    wire reg_write_en_out;
    wire data_mem_store_en_out;
    wire store_byte_en_out;
    wire store_half_en_out;
    wire store_word_en_out;
    wire data_mem_load_en_out;
    wire load_byte_en_out;
    wire load_half_en_out;
    wire load_word_en_out;
    wire load_byte_unsign_en_out;
    wire load_half_unsign_en_out;

    // Instantiate the RegAM module
    RegAM uut (
        .alu_result_in(alu_result_in),
        .dest_addr_in(dest_addr_in),
        .src2_data_in(src2_data_in),
        .reg_write_en_in(reg_write_en_in),
        .data_mem_store_en_in(data_mem_store_en_in),
        .store_byte_en_in(store_byte_en_in),
        .store_half_en_in(store_half_en_in),
        .store_word_en_in(store_word_en_in),
        .data_mem_load_en_in(data_mem_load_en_in),
        .load_byte_en_in(load_byte_en_in),
        .load_half_en_in(load_half_en_in),
        .load_word_en_in(load_word_en_in),
        .load_byte_unsign_en_in(load_byte_unsign_en_in),
        .load_half_unsign_en_in(load_half_unsign_en_in),

        .alu_result_out(alu_result_out),
        .dest_addr_out(dest_addr_out),
        .src2_data_out(src2_data_out),
        .reg_write_en_out(reg_write_en_out),
        .data_mem_store_en_out(data_mem_store_en_out),
        .store_byte_en_out(store_byte_en_out),
        .store_half_en_out(store_half_en_out),
        .store_word_en_out(store_word_en_out),
        .data_mem_load_en_out(data_mem_load_en_out),
        .load_byte_en_out(load_byte_en_out),
        .load_half_en_out(load_half_en_out),
        .load_word_en_out(load_word_en_out),
        .load_byte_unsign_en_out(load_byte_unsign_en_out),
        .load_half_unsign_en_out(load_half_unsign_en_out)
    );

    initial begin
        // Test case 1: Initial values
        alu_result_in = 32'h0000000A;
        dest_addr_in = 5'h1A;
        src2_data_in = 32'h0000000F;
        reg_write_en_in = 1;
        data_mem_store_en_in = 0;
        store_byte_en_in = 0;
        store_half_en_in = 1;
        store_word_en_in = 0;
        data_mem_load_en_in = 1;
        load_byte_en_in = 0;
        load_half_en_in = 1;
        load_word_en_in = 0;
        load_byte_unsign_en_in = 1;
        load_half_unsign_en_in = 0;
        #10;

        $display("Test 1:");
        $display("ALU Result: %d, Expected: 10", alu_result_out);
        $display("Dest Addr: %d, Expected: 26", dest_addr_out);
        $display("Src2 Data: %d, Expected: 15", src2_data_out);
        $display("Reg Write En: %b, Expected: 1", reg_write_en_out);
        $display("Data Mem Store En: %b, Expected: 0", data_mem_store_en_out);
        $display("Store Byte En: %b, Expected: 0", store_byte_en_out);
        $display("Store Half En: %b, Expected: 1", store_half_en_out);
        $display("Store Word En: %b, Expected: 0", store_word_en_out);
        $display("Data Mem Load En: %b, Expected: 1", data_mem_load_en_out);
        $display("Load Byte En: %b, Expected: 0", load_byte_en_out);
        $display("Load Half En: %b, Expected: 1", load_half_en_out);
        $display("Load Word En: %b, Expected: 0", load_word_en_out);
        $display("Load Byte Unsign En: %b, Expected: 1", load_byte_unsign_en_out);
        $display("Load Half Unsign En: %b, Expected: 0", load_half_unsign_en_out);

        // Test case 2: Change some inputs
        alu_result_in = 32'hFFFFFFF6;  // -10 in two's complement
        dest_addr_in = 5'h0A;
        src2_data_in = 32'h00000014;   // 20
        reg_write_en_in = 0;
        data_mem_store_en_in = 1;
        store_byte_en_in = 1;
        store_half_en_in = 0;
        store_word_en_in = 1;
        data_mem_load_en_in = 0;
        load_byte_en_in = 1;
        load_half_en_in = 0;
        load_word_en_in = 1;
        load_byte_unsign_en_in = 0;
        load_half_unsign_en_in = 1;
        #10;

        $display("Test 2:");
        $display("ALU Result: %d, Expected: -10", alu_result_out);
        $display("Dest Addr: %d, Expected: 10", dest_addr_out);
        $display("Src2 Data: %d, Expected: 20", src2_data_out);
        $display("Reg Write En: %b, Expected: 0", reg_write_en_out);
        $display("Data Mem Store En: %b, Expected: 1", data_mem_store_en_out);
        $display("Store Byte En: %b, Expected: 1", store_byte_en_out);
        $display("Store Half En: %b, Expected: 0", store_half_en_out);
        $display("Store Word En: %b, Expected: 1", store_word_en_out);
        $display("Data Mem Load En: %b, Expected: 0", data_mem_load_en_out);
        $display("Load Byte En: %b, Expected: 1", load_byte_en_out);
        $display("Load Half En: %b, Expected: 0", load_half_en_out);
        $display("Load Word En: %b, Expected: 1", load_word_en_out);
        $display("Load Byte Unsign En: %b, Expected: 0", load_byte_unsign_en_out);
        $display("Load Half Unsign En: %b, Expected: 1", load_half_unsign_en_out);

        // End simulation
        $finish;
    end

endmodule