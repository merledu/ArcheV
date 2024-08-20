module DataMemRouter_testbench;

    // Testbench signals
    reg signed [31:0] alu_result;
    reg signed [31:0] src2_data;
    reg signed [31:0] mem_data_in;

    reg load_en;
    reg store_en;
    reg store_signed_byte_en;
    reg store_unsigned_byte_en;
    reg load_signed_byte_en;
    reg load_unsigned_byte_en;
    reg store_signed_halfword_en;
    reg store_unsigned_halfword_en;
    reg load_signed_halfword_en;
    reg load_unsigned_halfword_en;
    reg store_signed_word_en;
    reg store_unsigned_word_en;
    reg load_signed_word_en;
    reg load_unsigned_word_en;

    wire signed [31:0] mem_data_out;
    wire signed [31:0] src_data_out;
    wire [15:0] address_out;
    wire store_en_out;
    wire load_en_out;

    // Instantiate the DataMemRouter module
    DataMemRouter uut (
        .alu_result(alu_result),
        .src2_data(src2_data),
        .mem_data_in(mem_data_in),
        .load_en(load_en),
        .store_en(store_en),
        .store_signed_byte_en(store_signed_byte_en),
        .store_unsigned_byte_en(store_unsigned_byte_en),
        .load_signed_byte_en(load_signed_byte_en),
        .load_unsigned_byte_en(load_unsigned_byte_en),
        .store_signed_halfword_en(store_signed_halfword_en),
        .store_unsigned_halfword_en(store_unsigned_halfword_en),
        .load_signed_halfword_en(load_signed_halfword_en),
        .load_unsigned_halfword_en(load_unsigned_halfword_en),
        .store_signed_word_en(store_signed_word_en),
        .store_unsigned_word_en(store_unsigned_word_en),
        .load_signed_word_en(load_signed_word_en),
        .load_unsigned_word_en(load_unsigned_word_en),
        .mem_data_out(mem_data_out),
        .src_data_out(src_data_out),
        .address_out(address_out),
        .store_en_out(store_en_out),
        .load_en_out(load_en_out)
    );

    initial begin
        // Test case 1: Store Byte Operation
        alu_result = 32'h00000010;
        src2_data = 32'sd12345678;
        mem_data_in = 32'sd0;
        store_signed_byte_en = 1;
        store_unsigned_byte_en = 0;
        store_en = 1;
        load_en = 0;
        #10;
        $display("Store Byte: Src2 Data Out: %h, Expected: %h", src_data_out, 32'h00000078);

        // Test case 2: Store Halfword Operation
        store_signed_byte_en = 0;
        store_signed_halfword_en = 1;
        #10;
        $display("Store Halfword: Src2 Data Out: %h, Expected: %h", src_data_out, 32'h00005678);

        // Test case 3: Store Word Operation
        store_signed_halfword_en = 0;
        store_signed_word_en = 1;
        #10;
        $display("Store Word: Src2 Data Out: %h, Expected: %h", src_data_out, 32'h12345678);

        // Test case 4: Load Signed Byte
        store_signed_word_en = 0;
        load_signed_byte_en = 1;
        mem_data_in = 32'h00000078;
        load_en = 1;
        store_en = 0;
        #10;
        $display("Load Signed Byte: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h00000078);

        // Test case 5: Load Signed Halfword
        load_signed_byte_en = 0;
        load_signed_halfword_en = 1;
        mem_data_in = 32'h00005678;
        #10;
        $display("Load Signed Halfword: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h00005678);

        // Test case 6: Load Signed Word
        load_signed_halfword_en = 0;
        load_signed_word_en = 1;
        mem_data_in = 32'h12345678;
        #10;
        $display("Load Signed Word: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h12345678);

        // Test case 7: Load Unsigned Byte
        load_signed_word_en = 0;
        load_unsigned_byte_en = 1;
        mem_data_in = 32'hFFFFFF78;
        #10;
        $display("Load Unsigned Byte: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h00000078);

        // Test case 8: Load Unsigned Halfword
        load_unsigned_byte_en = 0;
        load_unsigned_halfword_en = 1;
        mem_data_in = 32'hFFFF5678;
        #10;
        $display("Load Unsigned Halfword: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h00005678);

        // Test case 9: Load Unsigned Word
        load_unsigned_halfword_en = 0;
        load_unsigned_word_en = 1;
        mem_data_in = 32'h12345678;
        #10;
        $display("Load Unsigned Word: Mem Data Out: %h, Expected: %h", mem_data_out, 32'h12345678);

        // End simulation
        $finish;
    end

endmodule