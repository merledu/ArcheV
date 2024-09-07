module fetch_tb;
    reg [31:0] Forward_instr;  
    reg [31:0] Stallunit_inst;  
    reg [31:0] stallPC;  
    reg [31:0] forward_PC;  
    reg [31:0] StallUnit_PC;  
    reg [31:0] br_en;  
    reg [31:0] jal_en;  
    reg signed [31:0] imm;  
    reg [31:0] RegFD_PC;  
    reg [31:0] jalr_en;  
    reg [31:0] jalr_PC;  

    wire [31:0] pc_out;  
    wire [31:0] PC4;  
    wire [31:0] nPC_out;  
    wire [31:0] addr;  
    
    fetch uut (
        .Forward_instr(Forward_instr),
        .Stallunit_inst(Stallunit_inst),
        .stallPC(stallPC),
        .forward_PC(forward_PC),
        .StallUnit_PC(StallUnit_PC),
        .br_en(br_en),
        .jal_en(jal_en),
        .imm(imm),
        .RegFD_PC(RegFD_PC),
        .jalr_en(jalr_en),
        .jalr_PC(jalr_PC),
        .pc_out(pc_out),
        .PC4(PC4),
        .nPC_out(nPC_out),
        .addr(addr)
    );

    integer file;
    integer status;

    initial begin
        file = $fopen("input.txt", "r");
       
        while (!$feof(file)) begin
            status = $fscanf(file, "%d %d %d %d %d %d %d %d %d %d %d",
                             Forward_instr, Stallunit_inst, stallPC, forward_PC,
                             StallUnit_PC, br_en, jal_en, imm, RegFD_PC, jalr_en, jalr_PC);
            if (status == 11) 
            begin
                #10;
                $display("pc_out: %d", pc_out);
                $display("PC4: %d", PC4);
                $display("nPC_out: %d", nPC_out);
                $display("addr: %d", addr);
                $display("-");

            end
        end
        $fclose(file);
        $finish;
    end
endmodule
