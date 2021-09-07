module main_datapath(
    input i_clk,
    input i_nrst_pc,
    input i_nrst_regs,
    output [31:0] o_curr_rom_out,
    output [1:0] o_forwardA,
    output [1:0] o_forwardB,
    output o_kill1,
    output o_kill2,
    output o_stall
);

wire [31:0]
    curr_pc_addr,
    rom_out,
    rom_instruction,
    instruction,
    rdata1_regfile,
    rdata2_regfile,
    extend_out,
    mux_regfile_to_regA,
    mux_regfile_to_regB,
    regA_out,
    regB_out,
    regIMM_out,
    regfile_to_alu,
    alu_result,
    regR_out,
    regD_out,
    main_databus,
    main_databus_to_regfile,
    reg_main_databus;

wire [29:0]
    regBTA_out,
    next_pc_addr,
    pc_plus4,
    NPC_reg_out,
    jump_addr,
    adder_out;

wire [10:0]
    ctrl_to_regEX,
    regEX_out;

wire [4:0]
    regRD_EX_out,
    instruction_to_regfile,
    regSA_out,
    regRD_MM_out,
    regRD_WB_out;

wire [3:0]
    regMM_out,
    __SIG_alu_control;

wire [1:0]
    __SIG_forwardA,
    __SIG_forwardB,
    __SIG_alu_op,
    __SIG_next_pc_src;

wire 
    regWB_out,
    __SIG_kill2_or_stall,
    __SIG_stall,
    __SIG_alu_zf,
    __SIG_reg_dst,
    __SIG_jump,
    __SIG_beq,
    __SIG_bne,
    __SIG_extend,
    __SIG_mem_reg,
    __SIG_mem_wr,
    __SIG_mem_rd,
    __SIG_alu_src,
    __SIG_reg_wr,
    __SIG_kill1,
    __SIG_kill2;
    
assign o_curr_rom_out = rom_out;
assign o_forwardA = __SIG_forwardA;
assign o_forwardB = __SIG_forwardB;
assign o_kill1 = __SIG_kill1;
assign o_kill2 = __SIG_kill2;
assign o_stall = __SIG_stall;

mux_i3_x1 #( .DATA_WIDTH(30) )
mux_main_pc(
    .i_data0(pc_plus4),
    .i_data1(jump_addr),
    .i_data2(regBTA_out),
    .i_control(__SIG_next_pc_src),
    .o_data(next_pc_addr)
);

proc_count main_pc( 
    .i_clk(i_clk),
    .i_nrst(i_nrst_pc),
    .i_en(__SIG_stall),
    .i_pc({next_pc_addr,2'b00}),
    .o_pc(curr_pc_addr)
);

always @(posedge i_clk) begin
    $display("next pc:\t%b - %h - [%d]", {next_pc_addr,2'b00}, {next_pc_addr,2'b00}, {next_pc_addr,2'b00});
    $display("curr pc:\t%b - %h - [%d]", curr_pc_addr, curr_pc_addr, curr_pc_addr);
end

adder #( .DATA_WIDTH(30) )
pc_adder(	
    .i_opA(30'b1),
    .i_opB(curr_pc_addr[31:2]),
    .o_result(pc_plus4)
);

ms_reg #( .DATA_WIDTH(30), .REGNAME("NPC") )
NPC_reg(
    .i_clk(i_clk), 
    .i_data(pc_plus4), 
    .i_en(__SIG_stall), 
    .i_nrst(i_nrst_regs), 
    .o_data(NPC_reg_out)
);

rom #( .ADDR_WIDTH(5), .DATA_WIDTH(32) )
main_rom(	
    .i_addr(curr_pc_addr[6:2]),
    .o_data(rom_out)
);

mux_i2_x1 #( .DATA_WIDTH(32) )
mux_rom_instruction(
    .i_data0(rom_out), 
    .i_data1(32'b0),
    .i_control(__SIG_kill1), 
    .o_data(rom_instruction)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("INST") )
INST_reg(
    .i_clk(i_clk), 
    .i_data(rom_instruction), 
    .i_en(__SIG_stall), 
    .i_nrst(i_nrst_regs), 
    .o_data(instruction)
);

mux_i2_x1 #( .DATA_WIDTH(5) )
mux_rom_to_regfile(	
    .i_data0(instruction[20:16]),  
    .i_data1(instruction[15:11]),  
    .i_control(__SIG_reg_dst),
    .o_data(instruction_to_regfile)
);

regfile gp_regfile(
    .i_clk(i_clk), 
    .i_nrst(i_nrst_pc),
    .i_raddr1(instruction[25:21]), 
    .i_raddr2(instruction[20:16]), 
    .i_waddr(regRD_WB_out), 
    .i_wdata(reg_main_databus), 
    .i_we(regWB_out),
    .o_rdata1(rdata1_regfile),
    .o_rdata2(rdata2_regfile) 
);

sign_extend sign_extender( 
    .i_data(instruction[15:0]),
    .i_en(__SIG_extend),
    .o_data(extend_out)
);

mux_i4_x1 #( .DATA_WIDTH(32) )
mux_regfile_to_A (
    .i_data0(rdata1_regfile), 
    .i_data1(alu_result), 
    .i_data2(main_databus_to_regfile), 
    .i_data3(reg_main_databus), 
    .i_control(__SIG_forwardA), 
    .o_data(mux_regfile_to_regA)
);

mux_i4_x1 #( .DATA_WIDTH(32) )
mux_regfile_to_B (
    .i_data0(rdata2_regfile), 
    .i_data1(alu_result), 
    .i_data2(main_databus_to_regfile), 
    .i_data3(reg_main_databus), 
    .i_control(__SIG_forwardB), 
    .o_data(mux_regfile_to_regB)
); 

assign __SIG_kill2_or_stall = __SIG_kill2 | __SIG_stall;

mux_i2_x1 #( .DATA_WIDTH(11) )
mux_ctrl_to_EX_reg(	
    .i_data0({__SIG_beq,__SIG_bne,__SIG_mem_reg,__SIG_mem_wr,__SIG_mem_rd,__SIG_alu_src,__SIG_reg_wr,__SIG_alu_control}), 
    .i_data1(11'b0), 
    .i_control(__SIG_kill2_or_stall),
    .o_data(ctrl_to_regEX)
);

ms_reg #( .DATA_WIDTH(30), .REGNAME("BTA") )
BTA_reg(
    .i_clk(i_clk), 
    .i_data(adder_out), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regBTA_out)
);

ms_reg #( .DATA_WIDTH(5), .REGNAME("SA") )
SA_reg(
    .i_clk(i_clk), 
    .i_data(instruction[10:6]), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regSA_out)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("Imm") )
IMM_reg (
    .i_clk(i_clk), 
    .i_data(extend_out), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regIMM_out)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("A") )
A_reg (
    .i_clk(i_clk), 
    .i_data(mux_regfile_to_regA), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regA_out)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("B") )
B_reg (  
    .i_clk(i_clk), 
    .i_data(mux_regfile_to_regB), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regB_out)
);

ms_reg #( .DATA_WIDTH(5), .REGNAME("Rd_Ex") )
RD_EX_reg (
    .i_clk(i_clk), 
    .i_data(instruction_to_regfile), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regRD_EX_out)
);

ms_reg #( .DATA_WIDTH(11), .REGNAME("EX") )
EX_reg (
    .i_clk(i_clk), 
    .i_data(ctrl_to_regEX),
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regEX_out)
);

mux_i2_x1 #( .DATA_WIDTH(32) )
mux_regfile_to_alu 	(
    .i_data0(regB_out), 
    .i_data1(regIMM_out), 
    .i_control(regEX_out[5]), 
    .o_data(regfile_to_alu)
);

alu main_alu(	
    .i_opA(regA_out), 
    .i_opB(regfile_to_alu), 
    .i_control(regEX_out[3:0]), 
    .i_shift(regSA_out),
    .o_result(alu_result), 
    .o_zf(__SIG_alu_zf)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("R") )
R_reg (
    .i_clk(i_clk), 
    .i_data(alu_result), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regR_out)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("D") )
D_reg (
    .i_clk(i_clk), 
    .i_data(regB_out), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regD_out)
);

ms_reg #( .DATA_WIDTH(5), .REGNAME("Rd_MEM") )
RD_MEM_reg (
    .i_clk(i_clk), 
    .i_data(regRD_EX_out), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regRD_MM_out)
);

ms_reg #( .DATA_WIDTH(4), .REGNAME("MEM") )
MEM_reg (
    .i_clk(i_clk), 
    .i_data({regEX_out[8],regEX_out[7],regEX_out[6],regEX_out[4]}), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regMM_out)
);

ram #( .DATA_WIDTH(32), .ADDR_WIDTH(4) )
main_ram(	
    .i_clk(i_clk),
    .i_addr(regR_out[3:0]),
    .i_data(regD_out),
    .i_we(regMM_out[2]), 
    .o_data(main_databus)
);

mux_i2_x1 #( .DATA_WIDTH(32) )
mux_data_to_regfile(	
    .i_data0(regR_out), 
    .i_data1(main_databus), 
    .i_control(regMM_out[3]),
    .o_data(main_databus_to_regfile)
);

ms_reg #( .DATA_WIDTH(32), .REGNAME("Data") )
DATA_reg (
    .i_clk(i_clk), 
    .i_data(main_databus_to_regfile), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(reg_main_databus)
);

ms_reg #( .DATA_WIDTH(5), .REGNAME("Rd_WB") )
RD_WB_reg(
    .i_clk(i_clk), 
    .i_data(regRD_MM_out), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regRD_WB_out)
);

ms_reg #( .DATA_WIDTH(1), .REGNAME("WB") )
WB_reg(
    .i_clk(i_clk), 
    .i_data(regMM_out[0]), 
    .i_en(1'b0), 
    .i_nrst(i_nrst_regs), 
    .o_data(regWB_out)
);

ctrl_unit main_control(  
    .i_instr_code(instruction[31:26]), 
    .o_reg_dst(__SIG_reg_dst),
    .o_jump(__SIG_jump), 
    .o_beq(__SIG_beq),
    .o_bne(__SIG_bne),
    .o_extend(__SIG_extend),
    .o_mem_reg(__SIG_mem_reg),
    .o_alu_op(__SIG_alu_op),
    .o_mem_wr(__SIG_mem_wr),
    .o_mem_rd(__SIG_mem_rd),
    .o_alu_src(__SIG_alu_src),
    .o_reg_wr(__SIG_reg_wr)
);

hazard_unit hazard_unit(
    .i_reg_s(instruction[25:21]),
    .i_reg_t(instruction[20:16]),
    .i_reg_d_EX(regRD_EX_out),
    .i_reg_d_MM(regRD_MM_out),
    .i_reg_d_WB(regRD_WB_out),
    .i_reg_wr_EX(regEX_out[4]),
    .i_reg_wr_MM(regMM_out[0]),
    .i_reg_wr_WB(regWB_out),
    .i_mem_rd_EX(regEX_out[6]),
    .o_forwardA(__SIG_forwardA),
    .o_forwardB(__SIG_forwardB),
    .o_stall(__SIG_stall)
);

alu_control main_alu_control(	
    .i_alu_op(__SIG_alu_op[1:0]), 
    .i_func(instruction[5:0]),
    .o_alu_ctrl(__SIG_alu_control)
);

assign jump_addr = { NPC_reg_out[29:26], instruction[25:0] };

adder #( .DATA_WIDTH(30) )
pc_next_adder(	
    .i_opA(NPC_reg_out),
    .i_opB(extend_out[29:0]),
    .o_result(adder_out)	
);

jump_unit jump_taker(
    .i_zero(__SIG_alu_zf),
    .i_jump(__SIG_jump),   
    .i_beq(regEX_out[10]),
    .i_bne(regEX_out[9]),
    .o_pc_src(__SIG_next_pc_src),
    .o_kill1(__SIG_kill1),
    .o_kill2(__SIG_kill2)
);

endmodule
