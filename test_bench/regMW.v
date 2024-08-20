module RegMW_testbench;

    // Testbench signals
    reg signed [31:0] alu_data_in;
    reg [31:0] load_data_in;
    reg [4:0] dest_reg_addr_in;
    reg write_enable_in;
    reg load_enable_in;

    wire signed [31:0] alu_data_out;
    wire [31:0] load_data_out;
    wire [4:0] dest_reg_addr_out;
    wire write_enable_out;
    wire load_enable_out;

    // Instantiate the RegMW module
    RegMW uut (
        .alu_data_in(alu_data_in),
        .load_data_in(load_data_in),
        .dest_reg_addr_in(dest_reg_addr_in),
        .write_enable_in(write_enable_in),
        .load_enable_in(load_enable_in),
        .alu_data_out(alu_data_out),
        .load_data_out(load_data_out),
        .dest_reg_addr_out(dest_reg_addr_out),
        .write_enable_out(write_enable_out),
        .load_enable_out(load_enable_out)
    );

    initial begin
        // Test case 1: Basic initialization
        alu_data_in = 32'sd100;
        load_data_in = 32'hDEADBEEF;
        dest_reg_addr_in = 5'd10;
        write_enable_in = 1;
        load_enable_in = 0;
        #10;

        $display("Test 1:");
        $display("ALU Data: %d, Expected: 100", alu_data_out);
        $display("Load Data: %h, Expected: DEADBEEF", load_data_out);
        $display("Dest Reg Addr: %d, Expected: 10", dest_reg_addr_out);
        $display("Write Enable: %b, Expected: 1", write_enable_out);
        $display("Load Enable: %b, Expected: 0", load_enable_out);

        // Test case 2: Change values
        alu_data_in = -32'sd200;
        load_data_in = 32'hCAFEBABE;
        dest_reg_addr_in = 5'd15;
        write_enable_in = 0;
        load_enable_in = 1;
        #10;

        $display("Test 2:");
        $display("ALU Data: %d, Expected: -200", alu_data_out);
        $display("Load Data: %h, Expected: CAFEBABE", load_data_out);
        $display("Dest Reg Addr: %d, Expected: 15", dest_reg_addr_out);
        $display("Write Enable: %b, Expected: 0", write_enable_out);
        $display("Load Enable: %b, Expected: 1", load_enable_out);

        // End simulation
        $finish;
    end

endmodule