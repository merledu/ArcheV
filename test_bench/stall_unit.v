module stall_unit_tb;
    reg [31:0] RegFD_inst;  
    reg [31:0] load_En;  
    reg [31:0] RegDA_rd_addr;  
    reg [31:0] pc_in;  
    reg [31:0] stallPC_in;  
    reg [31:0] rs1_addr;  
    reg [31:0] rs2_addr;  

    wire [31:0] forward_inst;  
    wire [31:0] forward_PC;  
    wire [31:0] stallControl;  
    wire [31:0] inst;  
    wire [31:0] PC_out;  
    wire [31:0] stallPC_out;  
    
    stall_unit uut (
        .RegFD_inst(RegFD_inst),
        .load_En(load_En),
        .RegDA_rd_addr(RegDA_rd_addr),
        .pc_in(pc_in),
        .stallPC_in(stallPC_in),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .forward_inst(forward_inst),
        .forward_PC(forward_PC),
        .stallControl(stallControl),
        .inst(inst),
        .PC_out(PC_out),
        .stallPC_out(stallPC_out)
    );

    integer file;
    integer status;

    initial begin
        file = $fopen("input.txt", "r");
       
        while (!$feof(file)) begin
            status = $fscanf(file, "%d %d %d %d %d %d %d",
                             RegFD_inst, load_En, RegDA_rd_addr, pc_in,
                             stallPC_in, rs1_addr, rs2_addr);
            if (status == 7) 
            begin
                #10;
                $display("forward_inst: %d", forward_inst);
                $display("forward_PC: %d", forward_PC);
                $display("stallControl: %d", stallControl);
                $display("inst: %d", inst);
                $display("PC_out: %d", PC_out);
                $display("stallPC_out: %d", stallPC_out);
                $display("-");

            end
        end
        $fclose(file);
        $finish;
    end
endmodule
