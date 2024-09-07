module decode_tb;
    reg [31:0] instruction;  

    wire [31:0] opcode;  
    wire [31:0] rd_addr;  
    wire [31:0] func3;  
    wire [31:0] rs1_addr;  
    wire [31:0] rs2_addr;  
    wire [31:0] func7;  
    wire signed[31:0] imm;  
    wire [31:0] r_id;  
    wire [31:0] i_math_id;  
    wire [31:0] i_load_id;  
    wire [31:0] i_jalr_id;  
    wire [31:0] s_id;  
    wire [31:0] b_id;  
    wire [31:0] u_auipc_id;  
    wire [31:0] u_lui_id;  
    wire [31:0] j_id;  
    
    decode uut (
        .instruction(instruction),
        .opcode(opcode),
        .rd_addr(rd_addr),
        .func3(func3),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .func7(func7),
        .imm(imm),
        .r_id(r_id),
        .i_math_id(i_math_id),
        .i_load_id(i_load_id),
        .i_jalr_id(i_jalr_id),
        .s_id(s_id),
        .b_id(b_id),
        .u_auipc_id(u_auipc_id),
        .u_lui_id(u_lui_id),
        .j_id(j_id)
    );

    integer file;
    integer status;

    initial begin
        file = $fopen("input.txt", "r");
       
        while (!$feof(file)) begin
            status = $fscanf(file, "%d",
                             instruction);
            if (status == 1) 
            begin
                #10;
                $display("opcode: %d", opcode);
                $display("rd_addr: %d", rd_addr);
                $display("func3: %d", func3);
                $display("rs1_addr: %d", rs1_addr);
                $display("rs2_addr: %d", rs2_addr);
                $display("func7: %d", func7);
                $display("imm: %d", imm);
                $display("r_id: %d", r_id);
                $display("i_math_id: %d", i_math_id);
                $display("i_load_id: %d", i_load_id);
                $display("i_jalr_id: %d", i_jalr_id);
                $display("s_id: %d", s_id);
                $display("b_id: %d", b_id);
                $display("u_auipc_id: %d", u_auipc_id);
                $display("u_lui_id: %d", u_lui_id);
                $display("j_id: %d", j_id);
                $display("-");

            end
        end
        $fclose(file);
        $finish;
    end
endmodule
