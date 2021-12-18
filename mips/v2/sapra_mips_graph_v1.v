// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// PROGRAM		"Quartus II 64-Bit"
// VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
// CREATED		"Fri Dec  3 14:32:23 2021"

module sapra_mips_graph_v1(
	CLOCK_50,
	IRQ1_IN,
	KEY,
	__STALL,
	IRQ_JAL,
	__LINES,
	__SIG_JUMPS,
	__SIG_PC_SRC,
	CURR_PC,
	GPIO_1,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,
	INSTR,
	IRQ_EN,
	IRQ_NUM,
	VECTOR
);


input wire	CLOCK_50;
input wire	IRQ1_IN;
input wire	[0:0] KEY;
output wire	__STALL;
output wire	IRQ_JAL;
output wire	[3:0] __LINES;
output wire	[3:0] __SIG_JUMPS;
output wire	[1:0] __SIG_PC_SRC;
output wire	[31:0] CURR_PC;
output wire	[2:0] GPIO_1;
output wire	[6:0] HEX0;
output wire	[6:0] HEX1;
output wire	[6:0] HEX2;
output wire	[6:0] HEX3;
output wire	[6:0] HEX4;
output wire	[6:0] HEX5;
output wire	[6:0] HEX6;
output wire	[6:0] HEX7;
output wire	[31:0] INSTR;
output wire	[3:0] IRQ_EN;
output wire	[1:0] IRQ_NUM;
output wire	[31:0] VECTOR;

wire	[1:0] __IRQ_num;
wire	__LED_ready;
wire	__LINE_irq0;
wire	__LINE_irq1;
wire	__LINE_irq2;
wire	__LINE_irq3;
wire	[3:0] __SIG_alu_control;
wire	[2:0] __SIG_alu_op;
wire	__SIG_alu_src;
wire	__SIG_alu_zf;
wire	__SIG_any_irq_trig;
wire	__SIG_beq;
wire	__SIG_bne;
wire	__SIG_extend;
wire	[1:0] __SIG_forwardA;
wire	[1:0] __SIG_forwardB;
wire	__SIG_irq0;
wire	__SIG_irq1;
wire	__SIG_irq2;
wire	__SIG_irq3;
wire	__SIG_irq_jal;
wire	__SIG_jmp_reg;
wire	__SIG_jump;
wire	__SIG_kill1;
wire	__SIG_kill2;
wire	__SIG_kill2_or_stall;
wire	__SIG_mem_rd;
wire	[1:0] __SIG_mem_reg;
wire	__SIG_mem_wr;
wire	[1:0] __SIG_next_pc_src;
wire	[1:0] __SIG_reg_dst;
wire	__SIG_reg_wr;
wire	__SIG_stall;
wire	[29:0] adder_out;
wire	[31:0] alu_result;
wire	clk;
wire	clk_2mhz;
wire	[12:0] ctrl_to_regEX;
wire	[12:0] ctrl_to_regEX_mux;
wire	[31:0] curr_pc_addr;
wire	[31:0] extend_out;
wire	[31:0] Ground = 32'h0000_0000;
wire	[31:0] Vcc = 32'hffff_ffff;
wire	[31:0] instruction;
wire	[4:0] instruction_to_regfile;
wire	[3:0] irq_addr;
wire	[31:0] irq_block;
wire	[29:0] jump_addr;
wire	[31:0] main_databus;
wire	[31:0] main_databus_to_regfile;
wire	[31:0] main_rom_out;
wire	[3:0] memblock_i_oe;
wire	[3:0] memblock_i_we;
wire	[31:0] mux_regfile_to_regA;
wire	[31:0] mux_regfile_to_regB;
wire	[31:0] next_pc;
wire	[29:0] next_pc_addr;
wire	[29:0] NPC_reg_out;
wire	nrst;
wire	[29:0] pc_plus4;
wire	[31:0] ram_block0;
wire	[31:0] ram_block1;
wire	[31:0] rdata1_regfile;
wire	[31:0] rdata2_regfile;
wire	[31:0] reg_main_databus;
wire	[31:0] regA_out;
wire	[31:0] regB_out;
wire	[29:0] regBTA_out;
wire	[31:0] regD_out;
wire	[12:0] regEX_out;
wire	[31:0] regfile_to_alu;
wire	[31:0] regIMM_out;
wire	[29:0] regLINK_out;
wire	[4:0] regMM_out;
wire	[31:0] regR_out;
wire	[4:0] regRD_EX_out;
wire	[4:0] regRD_MM_out;
wire	[4:0] regRD_wb_out;
wire	[4:0] regSA_out;
wire	regWB_out;
wire	[31:0] rom_instruction;
wire	[31:0] rom_out;
wire	[31:0] vector_out;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_11;
wire	SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_15;
wire	[3:0] SYNTHESIZED_WIRE_16;
wire	[31:0] SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	[29:0] SYNTHESIZED_WIRE_19;
wire	[29:0] SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_22;
wire	[29:0] SYNTHESIZED_WIRE_23;
wire	SYNTHESIZED_WIRE_24;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_26;
wire	SYNTHESIZED_WIRE_27;
wire	SYNTHESIZED_WIRE_28;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_30;

assign	SYNTHESIZED_WIRE_0 = 0;
assign	SYNTHESIZED_WIRE_1 = 0;
assign	SYNTHESIZED_WIRE_2 = 0;
assign	SYNTHESIZED_WIRE_3 = 0;
assign	SYNTHESIZED_WIRE_4 = 0;
assign	SYNTHESIZED_WIRE_5 = 0;
assign	SYNTHESIZED_WIRE_6 = 0;
assign	SYNTHESIZED_WIRE_15 = 0;
assign	SYNTHESIZED_WIRE_18 = 0;
assign	SYNTHESIZED_WIRE_22 = 0;
assign	SYNTHESIZED_WIRE_24 = 0;
assign	SYNTHESIZED_WIRE_25 = 0;
assign	SYNTHESIZED_WIRE_26 = 0;
assign	SYNTHESIZED_WIRE_27 = 0;
assign	SYNTHESIZED_WIRE_28 = 0;
assign	SYNTHESIZED_WIRE_30 = 0;
wire	[3:0] GDFX_TEMP_SIGNAL_2;
wire	[12:0] GDFX_TEMP_SIGNAL_0;
wire	[29:0] GDFX_TEMP_SIGNAL_6;
wire	[3:0] GDFX_TEMP_SIGNAL_3;
wire	[4:0] GDFX_TEMP_SIGNAL_4;
wire	[31:0] GDFX_TEMP_SIGNAL_5;
wire	[31:0] GDFX_TEMP_SIGNAL_1;


assign	GDFX_TEMP_SIGNAL_2 = {__LINE_irq3,__LINE_irq2,__LINE_irq1,__LINE_irq0};
assign	GDFX_TEMP_SIGNAL_0 = {__SIG_jmp_reg,__SIG_beq,__SIG_bne,__SIG_mem_reg[1:0],__SIG_mem_wr,__SIG_mem_rd,__SIG_alu_src,__SIG_reg_wr,__SIG_alu_control[3:0]};
assign	GDFX_TEMP_SIGNAL_6 = {NPC_reg_out[29:26],instruction[25:0]};
assign	GDFX_TEMP_SIGNAL_3 = {__SIG_irq3,__SIG_irq2,__SIG_irq1,__SIG_irq0};
assign	GDFX_TEMP_SIGNAL_4 = {regEX_out[9],regEX_out[8],regEX_out[7],regEX_out[6],regEX_out[4]};
assign	GDFX_TEMP_SIGNAL_5 = {regLINK_out[29:0],Ground[1:0]};
assign	GDFX_TEMP_SIGNAL_1 = {next_pc_addr[29:0],Ground[1:0]};


ms_reg	b2v_A_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_0),
	.i_data(mux_regfile_to_regA),
	.o_data(regA_out));
	defparam	b2v_A_reg.DATA_WIDTH = 32;
	defparam	b2v_A_reg.REGNAME = "A";


ms_reg	b2v_B_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_1),
	.i_data(mux_regfile_to_regB),
	.o_data(regB_out));
	defparam	b2v_B_reg.DATA_WIDTH = 32;
	defparam	b2v_B_reg.REGNAME = "A";


ms_reg	b2v_BTA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_2),
	.i_data(adder_out),
	.o_data(regBTA_out));
	defparam	b2v_BTA_reg.DATA_WIDTH = 30;
	defparam	b2v_BTA_reg.REGNAME = "BTA";

assign	ctrl_to_regEX_mux = GDFX_TEMP_SIGNAL_0;



ms_reg	b2v_D_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_3),
	.i_data(regB_out),
	.o_data(regD_out));
	defparam	b2v_D_reg.DATA_WIDTH = 32;
	defparam	b2v_D_reg.REGNAME = "D";


ms_reg	b2v_DATA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_4),
	.i_data(main_databus_to_regfile),
	.o_data(reg_main_databus));
	defparam	b2v_DATA_reg.DATA_WIDTH = 32;
	defparam	b2v_DATA_reg.REGNAME = "DATA";


one_hot_div	b2v_div_clk(
	.i_clk(clk),
	.i_nrst(nrst)
	);
	defparam	b2v_div_clk.DIV_CONST = 25;
	defparam	b2v_div_clk.DUTY = 16'b0001111111111111;


one_hot_div	b2v_div_clk2(
	.i_clk(clk),
	.i_nrst(nrst),
	.o_clk(clk_2mhz));
	defparam	b2v_div_clk2.DIV_CONST = 2;
	defparam	b2v_div_clk2.DUTY = 4'b0001;


ms_reg	b2v_EX_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_5),
	.i_data(ctrl_to_regEX),
	.o_data(regEX_out));
	defparam	b2v_EX_reg.DATA_WIDTH = 13;
	defparam	b2v_EX_reg.REGNAME = "EX_reg";

assign	SYNTHESIZED_WIRE_17 = GDFX_TEMP_SIGNAL_1;



hazard_unit	b2v_hazard_unit(
	.i_reg_wr_EX(regEX_out[4]),
	.i_reg_wr_MM(regMM_out[0]),
	.i_reg_wr_WB(regWB_out),
	.i_mem_rd_EX(regEX_out[6]),
	.i_reg_d_EX(regRD_EX_out),
	.i_reg_d_MM(regRD_MM_out),
	.i_reg_d_WB(regRD_wb_out),
	.i_reg_s(instruction[25:21]),
	.i_reg_t(instruction[20:16]),
	.o_stall(__SIG_stall),
	.o_forwardA(__SIG_forwardA),
	.o_forwardB(__SIG_forwardB));


dec_7seg	b2v_HEXY0(
	.i_dat(instruction[3:0]),
	.o_seg(HEX0));


dec_7seg	b2v_HEXY1(
	.i_dat(instruction[7:4]),
	.o_seg(HEX1));


dec_7seg	b2v_HEXY2(
	.i_dat(instruction[11:8]),
	.o_seg(HEX2));


dec_7seg	b2v_HEXY3(
	.i_dat(instruction[15:12]),
	.o_seg(HEX3));


dec_7seg	b2v_HEXY4(
	.i_dat(instruction[19:16]),
	.o_seg(HEX4));


dec_7seg	b2v_HEXY5(
	.i_dat(instruction[23:20]),
	.o_seg(HEX5));


dec_7seg	b2v_HEXY6(
	.i_dat(instruction[27:24]),
	.o_seg(HEX6));


dec_7seg	b2v_HEXY7(
	.i_dat(instruction[31:28]),
	.o_seg(HEX7));



ms_reg	b2v_IMM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_6),
	.i_data(extend_out),
	.o_data(regIMM_out));
	defparam	b2v_IMM_reg.DATA_WIDTH = 32;
	defparam	b2v_IMM_reg.REGNAME = "IMM";


















ms_reg	b2v_INST_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(__SIG_stall),
	.i_data(rom_instruction),
	.o_data(instruction));
	defparam	b2v_INST_reg.DATA_WIDTH = 32;
	defparam	b2v_INST_reg.REGNAME = "INST";

assign	SYNTHESIZED_WIRE_29 =  ~__SIG_any_irq_trig;


redge_detect	b2v_irq0_detector(
	.i_clk(clk_2mhz),
	.i_sig(__LED_ready),
	.o_trig(__LINE_irq0));

assign	SYNTHESIZED_WIRE_7 = irq_block[0] & __LINE_irq0;

assign	__SIG_irq0 = SYNTHESIZED_WIRE_7 & SYNTHESIZED_WIRE_31;


redge_detect	b2v_irq1_detector(
	.i_clk(clk_2mhz),
	.i_sig(IRQ1_IN),
	.o_trig(__LINE_irq1));

assign	SYNTHESIZED_WIRE_9 = irq_block[1] & __LINE_irq1;

assign	__SIG_irq1 = SYNTHESIZED_WIRE_9 & SYNTHESIZED_WIRE_31;


redge_detect	b2v_irq2_detector(
	.i_clk(clk_2mhz),
	.i_sig(Ground[0]),
	.o_trig(__LINE_irq2));

assign	SYNTHESIZED_WIRE_11 = irq_block[2] & __LINE_irq2;

assign	__SIG_irq2 = SYNTHESIZED_WIRE_11 & SYNTHESIZED_WIRE_31;


redge_detect	b2v_irq3_detector(
	.i_clk(clk_2mhz),
	.i_sig(Ground[0]),
	.o_trig(__LINE_irq3));

assign	SYNTHESIZED_WIRE_13 = irq_block[3] & __LINE_irq3;

assign	__SIG_irq3 = SYNTHESIZED_WIRE_13 & SYNTHESIZED_WIRE_31;


ms_reg	b2v_irq_addr_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_15),
	.i_data(irq_addr),
	.o_data(SYNTHESIZED_WIRE_16));
	defparam	b2v_irq_addr_reg.DATA_WIDTH = 4;
	defparam	b2v_irq_addr_reg.REGNAME = "IRQ_ADDR_REG";


interrupt_control	b2v_irq_controller(
	.i_clk(clk),
	.i_we(memblock_i_we[0]),
	.i_nrst(nrst),
	.i_trig(__SIG_any_irq_trig),
	.i_data(regD_out),
	.i_irq(GDFX_TEMP_SIGNAL_2),
	.o_data(irq_block));
	defparam	b2v_irq_controller.DATA_WIDTH = 32;


prio_encoder_i4_x2	b2v_irq_line_encoder(
	.i_sig(SYNTHESIZED_WIRE_16),
	.o_zero(__SIG_irq_jal),
	.o_addr(__IRQ_num));

assign	irq_addr = GDFX_TEMP_SIGNAL_3;


assign	__SIG_any_irq_trig = __SIG_irq0 | __SIG_irq2 | __SIG_irq3 | __SIG_irq1;


mux_i2_x1	b2v_jump_reg_mux(
	.i_control(__SIG_jmp_reg),
	.i_data0(SYNTHESIZED_WIRE_17),
	.i_data1(mux_regfile_to_regA),
	.o_data(next_pc));
	defparam	b2v_jump_reg_mux.DATA_WIDTH = 32;


jump_unit	b2v_jump_taker(
	.i_zero(__SIG_alu_zf),
	.i_jump(__SIG_jump),
	.i_beq(regEX_out[11]),
	.i_bne(regEX_out[10]),
	.o_kill1(__SIG_kill1),
	.o_kill2(__SIG_kill2),
	.o_pc_src(__SIG_next_pc_src));

assign	__SIG_kill2_or_stall = __SIG_stall | __SIG_kill2;


led_driver	b2v_led_screen_driver(
	.in_clk(clk),
	.in_IR_START(irq_block[0]),
	.in_we(memblock_i_we[1]),
	.in_rst(nrst),
	.in_addr(regR_out[9:2]),
	.in_data(regD_out[15:0]),
	.out_IR_READY(__LED_ready),
	.out_LED_CLK(GPIO_1[0]),
	.out_MOSI(GPIO_1[1]),
	.out_CS(GPIO_1[2]));


constant_32b	b2v_link_minus_4(
	.o_value(SYNTHESIZED_WIRE_20));
	defparam	b2v_link_minus_4.DATA_WIDTH = 30;
	defparam	b2v_link_minus_4.VALUE = 1;


ms_reg	b2v_LINK_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_18),
	.i_data(NPC_reg_out),
	.o_data(SYNTHESIZED_WIRE_19));
	defparam	b2v_LINK_reg.DATA_WIDTH = 30;
	defparam	b2v_LINK_reg.REGNAME = "PC4_LINK";


subtractor	b2v_link_subtractor(
	.i_opA(SYNTHESIZED_WIRE_19),
	.i_opB(SYNTHESIZED_WIRE_20),
	.o_result(regLINK_out));
	defparam	b2v_link_subtractor.DATA_WIDTH = 30;


alu	b2v_main_alu(
	.i_control(regEX_out[3:0]),
	.i_opA(regA_out),
	.i_opB(regfile_to_alu),
	.i_shift(regSA_out),
	.o_zf(__SIG_alu_zf),
	.o_result(alu_result));


alu_control	b2v_main_alu_control(
	.i_alu_op(__SIG_alu_op),
	.i_func(instruction[5:0]),
	.o_alu_ctrl(__SIG_alu_control));


ctrl_unit	b2v_main_control(
	.i_instr_code(instruction[31:26]),
	.o_reg_wr(__SIG_reg_wr),
	.o_extend(__SIG_extend),
	.o_alu_src(__SIG_alu_src),
	.o_beq(__SIG_beq),
	.o_bne(__SIG_bne),
	.o_jump(__SIG_jump),
	.o_jmp_reg(__SIG_jmp_reg),
	.o_mem_wr(__SIG_mem_wr),
	.o_mem_rd(__SIG_mem_rd),
	.o_alu_op(__SIG_alu_op),
	.o_mem_reg(__SIG_mem_reg),
	.o_reg_dst(__SIG_reg_dst));



proc_count	b2v_main_pc(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_21),
	.i_pc(next_pc),
	.o_pc(curr_pc_addr));


ram	b2v_main_ram_block0(
	.i_clk(clk),
	.i_we(memblock_i_we[2]),
	.i_oe(memblock_i_oe[2]),
	.i_addr(regR_out[9:2]),
	.i_data(regD_out),
	.o_data(ram_block0));
	defparam	b2v_main_ram_block0.ADDR_WIDTH = 8;
	defparam	b2v_main_ram_block0.CELLS = 256;
	defparam	b2v_main_ram_block0.DATA_WIDTH = 32;


ram	b2v_main_ram_block1(
	.i_clk(clk),
	.i_we(memblock_i_we[3]),
	.i_oe(memblock_i_oe[3]),
	.i_addr(regR_out[9:2]),
	.i_data(regD_out),
	.o_data(ram_block1));
	defparam	b2v_main_ram_block1.ADDR_WIDTH = 8;
	defparam	b2v_main_ram_block1.CELLS = 256;
	defparam	b2v_main_ram_block1.DATA_WIDTH = 32;


regfile	b2v_main_regfile(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_we(regWB_out),
	.i_raddr1(instruction[25:21]),
	.i_raddr2(instruction[20:16]),
	.i_waddr(regRD_wb_out),
	.i_wdata(reg_main_databus),
	.o_rdata1(rdata1_regfile),
	.o_rdata2(rdata2_regfile));


rom	b2v_main_rom(
	.i_addr(curr_pc_addr[9:2]),
	.o_data(rom_out));
	defparam	b2v_main_rom.ADDR_WIDTH = 8;
	defparam	b2v_main_rom.CELLS = 256;
	defparam	b2v_main_rom.DATA_WIDTH = 32;


vector_rom	b2v_main_vector_table(
	.i_addr(__IRQ_num),
	.o_data(vector_out));
	defparam	b2v_main_vector_table.ADDR_WIDTH = 2;
	defparam	b2v_main_vector_table.CELLS = 4;
	defparam	b2v_main_vector_table.DATA_WIDTH = 32;


dec_i2_x4	b2v_mem_oe_dec(
	.i_we(regMM_out[1]),
	.i_addr(regR_out[11:10]),
	.o_sig(memblock_i_oe));


ms_reg	b2v_MEM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_22),
	.i_data(GDFX_TEMP_SIGNAL_4),
	.o_data(regMM_out));
	defparam	b2v_MEM_reg.DATA_WIDTH = 5;
	defparam	b2v_MEM_reg.REGNAME = "MEM";


dec_i2_x4	b2v_mem_we_dec(
	.i_we(regMM_out[2]),
	.i_addr(regR_out[11:10]),
	.o_sig(memblock_i_we));


mux_i2_x1	b2v_mux_ctrl_to_EX_reg(
	.i_control(__SIG_kill2_or_stall),
	.i_data0(ctrl_to_regEX_mux),
	.i_data1(Ground[12:0]),
	.o_data(ctrl_to_regEX));
	defparam	b2v_mux_ctrl_to_EX_reg.DATA_WIDTH = 13;


mux_i3_x1	b2v_mux_data_to_regfile_all(
	.i_control(regMM_out[4:3]),
	.i_data0(regR_out),
	.i_data1(main_databus),
	.i_data2(GDFX_TEMP_SIGNAL_5),
	.o_data(main_databus_to_regfile));
	defparam	b2v_mux_data_to_regfile_all.DATA_WIDTH = 32;


mux_i2_x1	b2v_mux_irq_or_mem(
	.i_control(__SIG_irq_jal),
	.i_data0(vector_out),
	.i_data1(main_rom_out),
	.o_data(rom_instruction));
	defparam	b2v_mux_irq_or_mem.DATA_WIDTH = 32;


mux_i2_x1	b2v_mux_jump_link(
	.i_control(regEX_out[12]),
	.i_data0(GDFX_TEMP_SIGNAL_6),
	.i_data1(regR_out[31:2]),
	.o_data(jump_addr));
	defparam	b2v_mux_jump_link.DATA_WIDTH = 30;


mux_i3_x1	b2v_mux_main_pc(
	.i_control(__SIG_next_pc_src),
	.i_data0(pc_plus4),
	.i_data1(jump_addr),
	.i_data2(regBTA_out),
	.o_data(next_pc_addr));
	defparam	b2v_mux_main_pc.DATA_WIDTH = 30;


mux_i4_x1	b2v_mux_memblocks(
	.i_control(regR_out[6:5]),
	.i_data0(irq_block),
	.i_data1(Ground),
	.i_data2(ram_block0),
	.i_data3(ram_block1),
	.o_data(main_databus));
	defparam	b2v_mux_memblocks.DATA_WIDTH = 32;


mux_i4_x1	b2v_mux_regfile_to_A(
	.i_control(__SIG_forwardA),
	.i_data0(rdata1_regfile),
	.i_data1(alu_result),
	.i_data2(main_databus_to_regfile),
	.i_data3(reg_main_databus),
	.o_data(mux_regfile_to_regA));
	defparam	b2v_mux_regfile_to_A.DATA_WIDTH = 32;


mux_i2_x1	b2v_mux_regfile_to_alu(
	.i_control(regEX_out[5]),
	.i_data0(regB_out),
	.i_data1(regIMM_out),
	.o_data(regfile_to_alu));
	defparam	b2v_mux_regfile_to_alu.DATA_WIDTH = 32;


mux_i4_x1	b2v_mux_regfile_to_B(
	.i_control(__SIG_forwardB),
	.i_data0(rdata2_regfile),
	.i_data1(alu_result),
	.i_data2(main_databus_to_regfile),
	.i_data3(reg_main_databus),
	.o_data(mux_regfile_to_regB));
	defparam	b2v_mux_regfile_to_B.DATA_WIDTH = 32;


mux_i2_x1	b2v_mux_rom_instruction(
	.i_control(__SIG_kill1),
	.i_data0(rom_out),
	.i_data1(Ground),
	.o_data(main_rom_out));
	defparam	b2v_mux_rom_instruction.DATA_WIDTH = 32;


mux_i3_x1	b2v_mux_rom_to_regfile(
	.i_control(__SIG_reg_dst),
	.i_data0(instruction[20:16]),
	.i_data1(instruction[15:11]),
	.i_data2(Vcc[4:0]),
	.o_data(instruction_to_regfile));
	defparam	b2v_mux_rom_to_regfile.DATA_WIDTH = 5;


ms_reg	b2v_NPC_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(__SIG_stall),
	.i_data(pc_plus4),
	.o_data(NPC_reg_out));
	defparam	b2v_NPC_reg.DATA_WIDTH = 30;
	defparam	b2v_NPC_reg.REGNAME = "NPC";


adder	b2v_pc_adder(
	.i_opA(SYNTHESIZED_WIRE_23),
	.i_opB(curr_pc_addr[31:2]),
	.o_result(pc_plus4));
	defparam	b2v_pc_adder.DATA_WIDTH = 30;


adder	b2v_pc_next_adder(
	.i_opA(NPC_reg_out),
	.i_opB(extend_out[29:0]),
	.o_result(adder_out));
	defparam	b2v_pc_next_adder.DATA_WIDTH = 30;


constant_32b	b2v_pc_plus4_const(
	.o_value(SYNTHESIZED_WIRE_23));
	defparam	b2v_pc_plus4_const.DATA_WIDTH = 30;
	defparam	b2v_pc_plus4_const.VALUE = 1;

assign	SYNTHESIZED_WIRE_31 =  ~irq_block[15];


ms_reg	b2v_R_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_24),
	.i_data(alu_result),
	.o_data(regR_out));
	defparam	b2v_R_reg.DATA_WIDTH = 32;
	defparam	b2v_R_reg.REGNAME = "R";


ms_reg	b2v_RD_EX_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_25),
	.i_data(instruction_to_regfile),
	.o_data(regRD_EX_out));
	defparam	b2v_RD_EX_reg.DATA_WIDTH = 5;
	defparam	b2v_RD_EX_reg.REGNAME = "RD_EX_reg";


ms_reg	b2v_RD_MEM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_26),
	.i_data(regRD_EX_out),
	.o_data(regRD_MM_out));
	defparam	b2v_RD_MEM_reg.DATA_WIDTH = 5;
	defparam	b2v_RD_MEM_reg.REGNAME = "RD_MEM";


ms_reg	b2v_RD_WB_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_27),
	.i_data(regRD_MM_out),
	.o_data(regRD_wb_out));
	defparam	b2v_RD_WB_reg.DATA_WIDTH = 5;
	defparam	b2v_RD_WB_reg.REGNAME = "RD_WB";


ms_reg	b2v_SA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_28),
	.i_data(instruction[10:6]),
	.o_data(regSA_out));
	defparam	b2v_SA_reg.DATA_WIDTH = 5;
	defparam	b2v_SA_reg.REGNAME = "SA";


sign_extend	b2v_sign_extender(
	.i_en(__SIG_extend),
	.i_data(instruction[15:0]),
	.o_data(extend_out));

assign	SYNTHESIZED_WIRE_21 = __SIG_stall & SYNTHESIZED_WIRE_29;


ms_reg	b2v_WB_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(SYNTHESIZED_WIRE_30),
	.i_data(regMM_out[0]),
	.o_data(regWB_out));
	defparam	b2v_WB_reg.DATA_WIDTH = 1;
	defparam	b2v_WB_reg.REGNAME = "WB";

assign	__STALL = __SIG_stall;
assign	clk = CLOCK_50;
assign	nrst = KEY;
assign	IRQ_JAL = __SIG_irq_jal;
assign	__LINES[3] = __LINE_irq3;
assign	__LINES[2] = __LINE_irq2;
assign	__LINES[1] = __LINE_irq1;
assign	__LINES[0] = __LINE_irq0;
assign	__SIG_JUMPS[3] = __SIG_jump;
assign	__SIG_JUMPS[2] = __SIG_beq;
assign	__SIG_JUMPS[1] = __SIG_bne;
assign	__SIG_JUMPS[0] = __SIG_jmp_reg;
assign	__SIG_PC_SRC = __SIG_next_pc_src;
assign	CURR_PC = curr_pc_addr;
assign	INSTR = instruction;
assign	IRQ_EN[3:0] = irq_block[3:0];
assign	IRQ_NUM = __IRQ_num;
assign	VECTOR = vector_out;

endmodule
