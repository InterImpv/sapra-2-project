module sapra_mips_graph_v1(
	CLOCK_50,
	KEY,
	GPIO_1
);

input wire	CLOCK_50;
input wire	[0:0] KEY;
output wire	[2:0] GPIO_1;

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
wire	[31:0] Ground;
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
wire	[31:0] Vcc;
wire	[31:0] vector_out;
wire	irq0_enable;
wire	__SIG_irq_pending;
wire	irq1_enable;
wire	irq2_enable;
wire	irq3_enable;
wire	[3:0] regIRQADDR_out;
wire	[31:0] final_pc_to_mux;
wire	[29:0] regLINK_out;
wire	__SIG_pc_stall;
wire	__SIG_irq_trigger;

assign	nrst = KEY;
wire	[3:0] __irq_liner;
wire	[12:0] __SIG_control_array;
wire	[29:0] next_pc_pipe;
wire	[3:0] __SIG_irq_main;
wire	[4:0] __SIG_execution;
wire	[31:0] link_pipe;
wire	[31:0] final_pc;

assign	__irq_liner = {__LINE_irq3,__LINE_irq2,__LINE_irq1,__LINE_irq0};
assign	__SIG_control_array = {__SIG_jmp_reg,__SIG_beq,__SIG_bne,__SIG_mem_reg[1:0],__SIG_mem_wr,__SIG_mem_rd,__SIG_alu_src,__SIG_reg_wr,__SIG_alu_control[3:0]};
assign	next_pc_pipe = {NPC_reg_out[29:26],instruction[25:0]};
assign	__SIG_irq_main = {__SIG_irq3,__SIG_irq2,__SIG_irq1,__SIG_irq0};
assign	__SIG_execution = {regEX_out[9],regEX_out[8],regEX_out[7],regEX_out[6],regEX_out[4]};
assign	link_pipe = {regLINK_out[29:0],Ground[1:0]};
assign	final_pc = {next_pc_addr[29:0],Ground[1:0]};

ms_reg	A_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(mux_regfile_to_regA),
	.o_data(regA_out)
	);
	defparam	A_reg.DATA_WIDTH = 32;
	defparam	A_reg.REGNAME = "A";

ms_reg	B_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(mux_regfile_to_regB),
	.o_data(regB_out)
	;
	defparam	B_reg.DATA_WIDTH = 32;
	defparam	B_reg.REGNAME = "A";

ms_reg	BTA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(adder_out),
	.o_data(regBTA_out)
	);
	defparam	BTA_reg.DATA_WIDTH = 30;
	defparam	BTA_reg.REGNAME = "BTA";

assign	ctrl_to_regEX_mux = __SIG_control_array;

ms_reg	D_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(regB_out),
	.o_data(regD_out)
	);
	defparam	D_reg.DATA_WIDTH = 32;
	defparam	D_reg.REGNAME = "D";

ms_reg	DATA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(main_databus_to_regfile),
	.o_data(reg_main_databus)
	);
	defparam	DATA_reg.DATA_WIDTH = 32;
	defparam	DATA_reg.REGNAME = "DATA";

one_hot_div	div_clk(
	.i_clk(CLOCK_50),
	.i_nrst(nrst),
	.o_clk(clk)
	);
	defparam	div_clk.DIV_CONST = 25;
	defparam	div_clk.DUTY = 16'b0001111111111111;

one_hot_div	div_clk2(
	.i_clk(CLOCK_50),
	.i_nrst(nrst),
	.o_clk(clk_2mhz)
	);
	defparam	div_clk2.DIV_CONST = 2;
	defparam	div_clk2.DUTY = 4'b0001;

ms_reg	EX_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(ctrl_to_regEX),
	.o_data(regEX_out)
	);
	defparam	EX_reg.DATA_WIDTH = 13;
	defparam	EX_reg.REGNAME = "EX_reg";

assign	final_pc_to_mux = final_pc;

hazard_unit	hazard_unit(
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
	.o_forwardB(__SIG_forwardB)
	);

ms_reg	IMM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(extend_out),
	.o_data(regIMM_out)
	);
	defparam	IMM_reg.DATA_WIDTH = 32;
	defparam	IMM_reg.REGNAME = "IMM";

ms_reg	INST_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(__SIG_stall),
	.i_data(rom_instruction),
	.o_data(instruction)
	);
	defparam	INST_reg.DATA_WIDTH = 32;
	defparam	INST_reg.REGNAME = "INST";

assign	__SIG_irq_trigger = ~__SIG_any_irq_trig;

redge_detect	irq0_detector(
	.i_clk(clk_2mhz),
	.i_sig(__LED_ready),
	.o_trig(__LINE_irq0)
	);

assign	irq0_enable = irq_block[0] & __LINE_irq0;
assign	__SIG_irq0 = irq0_enable & __SIG_irq_pending;

redge_detect	irq1_detector(
	.i_clk(clk_2mhz),
	.i_sig(Ground[0]),
	.o_trig(__LINE_irq1)
	);

assign	irq1_enable = irq_block[1] & __LINE_irq1;
assign	__SIG_irq1 = irq1_enable & __SIG_irq_pending;

redge_detect	irq2_detector(
	.i_clk(clk_2mhz),
	.i_sig(Ground[0]),
	.o_trig(__LINE_irq2)
	);

assign	irq2_enable = irq_block[2] & __LINE_irq2;
assign	__SIG_irq2 = irq2_enable & __SIG_irq_pending;

redge_detect	irq3_detector(
	.i_clk(clk_2mhz),
	.i_sig(Ground[0]),
	.o_trig(__LINE_irq3)
	);

assign	irq3_enable = irq_block[3] & __LINE_irq3;
assign	__SIG_irq3 = irq3_enable & __SIG_irq_pending;

ms_reg	irq_addr_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(irq_addr),
	.o_data(regIRQADDR_out)
	);
	defparam	irq_addr_reg.DATA_WIDTH = 4;
	defparam	irq_addr_reg.REGNAME = "IRQ_ADDR_REG";

interrupt_control	irq_controller(
	.i_clk(clk),
	.i_we(memblock_i_we[0]),
	.i_nrst(nrst),
	.i_trig(__SIG_any_irq_trig),
	.i_data(regD_out),
	.i_irq(__irq_liner),
	.o_data(irq_block)
	);
	defparam	irq_controller.DATA_WIDTH = 32;

prio_encoder_i4_x2	irq_line_encoder(
	.i_sig(regIRQADDR_out),
	.o_zero(__SIG_irq_jal),
	.o_addr(__IRQ_num)
	);

assign	irq_addr = __SIG_irq_main;

assign	__SIG_any_irq_trig = __SIG_irq0 | __SIG_irq2 | __SIG_irq3 | __SIG_irq1;

mux_i2_x1	jump_reg_mux(
	.i_control(__SIG_jmp_reg),
	.i_data0(final_pc_to_mux),
	.i_data1(mux_regfile_to_regA),
	.o_data(next_pc)
	);
	defparam	jump_reg_mux.DATA_WIDTH = 32;

jump_unit	jump_taker(
	.i_zero(__SIG_alu_zf),
	.i_jump(__SIG_jump),
	.i_beq(regEX_out[11]),
	.i_bne(regEX_out[10]),
	.o_kill1(__SIG_kill1),
	.o_kill2(__SIG_kill2),
	.o_pc_src(__SIG_next_pc_src)
	);

assign	__SIG_kill2_or_stall = __SIG_stall | __SIG_kill2;

led_driver	led_screen_driver(
	.in_clk(clk),
	.in_IR_START(irq_block[0]),
	.in_we(memblock_i_we[1]),
	.in_rst(nrst),
	.in_addr(regR_out[9:2]),
	.in_data(regD_out[15:0]),
	.out_IR_READY(__LED_ready),
	.out_LED_CLK(GPIO_1[0]),
	.out_MOSI(GPIO_1[1]),
	.out_CS(GPIO_1[2])
	);

ms_reg	LINK_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(NPC_reg_out),
	.o_data(regLINK_out)
	);
	defparam	LINK_reg.DATA_WIDTH = 30;
	defparam	LINK_reg.REGNAME = "PC4_LINK";

subtractor	link_subtractor(
	.i_opA(regLINK_out),
	.i_opB(30'd1),
	.o_result(regLINK_out)
	);
	defparam	link_subtractor.DATA_WIDTH = 30;

alu	main_alu(
	.i_control(regEX_out[3:0]),
	.i_opA(regA_out),
	.i_opB(regfile_to_alu),
	.i_shift(regSA_out),
	.o_zf(__SIG_alu_zf),
	.o_result(alu_result)
	);

alu_control	main_alu_control(
	.i_alu_op(__SIG_alu_op),
	.i_func(instruction[5:0]),
	.o_alu_ctrl(__SIG_alu_control)
	);

ctrl_unit	main_control(
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
	.o_reg_dst(__SIG_reg_dst)
	);


proc_count	main_pc(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(__SIG_pc_stall),
	.i_pc(next_pc),
	.o_pc(curr_pc_addr)
	);

ram	main_ram_block0(
	.i_clk(clk),
	.i_we(memblock_i_we[2]),
	.i_oe(memblock_i_oe[2]),
	.i_addr(regR_out[9:2]),
	.i_data(regD_out),
	.o_data(ram_block0)
	);
	defparam	main_ram_block0.ADDR_WIDTH = 8;
	defparam	main_ram_block0.CELLS = 256;
	defparam	main_ram_block0.DATA_WIDTH = 32;

ram	main_ram_block1(
	.i_clk(clk),
	.i_we(memblock_i_we[3]),
	.i_oe(memblock_i_oe[3]),
	.i_addr(regR_out[9:2]),
	.i_data(regD_out),
	.o_data(ram_block1)
	);
	defparam	main_ram_block1.ADDR_WIDTH = 8;
	defparam	main_ram_block1.CELLS = 256;
	defparam	main_ram_block1.DATA_WIDTH = 32;

regfile	main_regfile(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_we(regWB_out),
	.i_raddr1(instruction[25:21]),
	.i_raddr2(instruction[20:16]),
	.i_waddr(regRD_wb_out),
	.i_wdata(reg_main_databus),
	.o_rdata1(rdata1_regfile),
	.o_rdata2(rdata2_regfile)
	);

rom	main_rom(
	.i_addr(curr_pc_addr[9:2]),
	.o_data(rom_out)
	);
	defparam	main_rom.ADDR_WIDTH = 8;
	defparam	main_rom.CELLS = 256;
	defparam	main_rom.DATA_WIDTH = 32;

vector_rom	main_vector_table(
	.i_addr(__IRQ_num),
	.o_data(vector_out)
	);
	defparam	main_vector_table.ADDR_WIDTH = 2;
	defparam	main_vector_table.CELLS = 4;
	defparam	main_vector_table.DATA_WIDTH = 32;

dec_i2_x4	mem_oe_dec(
	.i_we(regMM_out[1]),
	.i_addr(regR_out[11:10]),
	.o_sig(memblock_i_oe)
	);

ms_reg	MEM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(__SIG_execution),
	.o_data(regMM_out)
	);
	defparam	MEM_reg.DATA_WIDTH = 5;
	defparam	MEM_reg.REGNAME = "MEM";

dec_i2_x4	mem_we_dec(
	.i_we(regMM_out[2]),
	.i_addr(regR_out[11:10]),
	.o_sig(memblock_i_we)
	);

mux_i2_x1	mux_ctrl_to_EX_reg(
	.i_control(__SIG_kill2_or_stall),
	.i_data0(ctrl_to_regEX_mux),
	.i_data1(Ground[12:0]),
	.o_data(ctrl_to_regEX)
	);
	defparam	mux_ctrl_to_EX_reg.DATA_WIDTH = 13;

mux_i3_x1	mux_data_to_regfile_all(
	.i_control(regMM_out[4:3]),
	.i_data0(regR_out),
	.i_data1(main_databus),
	.i_data2(link_pipe),
	.o_data(main_databus_to_regfile)
	);
	defparam	mux_data_to_regfile_all.DATA_WIDTH = 32;

mux_i2_x1	mux_irq_or_mem(
	.i_control(__SIG_irq_jal),
	.i_data0(vector_out),
	.i_data1(main_rom_out),
	.o_data(rom_instruction)
	);
	defparam	mux_irq_or_mem.DATA_WIDTH = 32;

mux_i2_x1	mux_jump_link(
	.i_control(regEX_out[12]),
	.i_data0(next_pc_pipe),
	.i_data1(regR_out[31:2]),
	.o_data(jump_addr)
	);
	defparam	mux_jump_link.DATA_WIDTH = 30;

mux_i3_x1	mux_main_pc(
	.i_control(__SIG_next_pc_src),
	.i_data0(pc_plus4),
	.i_data1(jump_addr),
	.i_data2(regBTA_out),
	.o_data(next_pc_addr)
	);
	defparam	mux_main_pc.DATA_WIDTH = 30;

mux_i4_x1	mux_memblocks(
	.i_control(regR_out[6:5]),
	.i_data0(irq_block),
	.i_data1(Ground),
	.i_data2(ram_block0),
	.i_data3(ram_block1),
	.o_data(main_databus)
	);
	defparam	mux_memblocks.DATA_WIDTH = 32;

mux_i4_x1	mux_regfile_to_A(
	.i_control(__SIG_forwardA),
	.i_data0(rdata1_regfile),
	.i_data1(alu_result),
	.i_data2(main_databus_to_regfile),
	.i_data3(reg_main_databus),
	.o_data(mux_regfile_to_regA)
	);
	defparam	mux_regfile_to_A.DATA_WIDTH = 32;

mux_i2_x1	mux_regfile_to_alu(
	.i_control(regEX_out[5]),
	.i_data0(regB_out),
	.i_data1(regIMM_out),
	.o_data(regfile_to_alu)
	);
	defparam	mux_regfile_to_alu.DATA_WIDTH = 32;

mux_i4_x1	mux_regfile_to_B(
	.i_control(__SIG_forwardB),
	.i_data0(rdata2_regfile),
	.i_data1(alu_result),
	.i_data2(main_databus_to_regfile),
	.i_data3(reg_main_databus),
	.o_data(mux_regfile_to_regB)
	);
	defparam	mux_regfile_to_B.DATA_WIDTH = 32;

mux_i2_x1	mux_rom_instruction(
	.i_control(__SIG_kill1),
	.i_data0(rom_out),
	.i_data1(Ground),
	.o_data(main_rom_out)
	);
	defparam	mux_rom_instruction.DATA_WIDTH = 32;

mux_i3_x1	mux_rom_to_regfile(
	.i_control(__SIG_reg_dst),
	.i_data0(instruction[20:16]),
	.i_data1(instruction[15:11]),
	.i_data2(Vcc[4:0]),
	.o_data(instruction_to_regfile)
	);
	defparam	mux_rom_to_regfile.DATA_WIDTH = 5;

ms_reg	NPC_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(__SIG_stall),
	.i_data(pc_plus4),
	.o_data(NPC_reg_out)
	);
	defparam	NPC_reg.DATA_WIDTH = 30;
	defparam	NPC_reg.REGNAME = "NPC";

adder	pc_adder(
	.i_opA(30'd1),
	.i_opB(curr_pc_addr[31:2]),
	.o_result(pc_plus4)
	);
	defparam	pc_adder.DATA_WIDTH = 30;

adder	pc_next_adder(
	.i_opA(NPC_reg_out),
	.i_opB(extend_out[29:0]),
	.o_result(adder_out)
	);
	defparam	pc_next_adder.DATA_WIDTH = 30;

assign	__SIG_irq_pending =  ~irq_block[15];

ms_reg	R_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(alu_result),
	.o_data(regR_out)
	);
	defparam	R_reg.DATA_WIDTH = 32;
	defparam	R_reg.REGNAME = "R";

ms_reg	RD_EX_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(instruction_to_regfile),
	.o_data(regRD_EX_out)
	);
	defparam	RD_EX_reg.DATA_WIDTH = 5;
	defparam	RD_EX_reg.REGNAME = "RD_EX_reg";


ms_reg	RD_MEM_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(regRD_EX_out),
	.o_data(regRD_MM_out)
	);
	defparam	RD_MEM_reg.DATA_WIDTH = 5;
	defparam	RD_MEM_reg.REGNAME = "RD_MEM";

ms_reg	RD_WB_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(regRD_MM_out),
	.o_data(regRD_wb_out)
	);
	defparam	RD_WB_reg.DATA_WIDTH = 5;
	defparam	RD_WB_reg.REGNAME = "RD_WB";

ms_reg	SA_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(instruction[10:6]),
	.o_data(regSA_out)
	);
	defparam	SA_reg.DATA_WIDTH = 5;
	defparam	SA_reg.REGNAME = "SA";

sign_extend	sign_extender(
	.i_en(__SIG_extend),
	.i_data(instruction[15:0]),
	.o_data(extend_out)
	);

assign	__SIG_pc_stall = __SIG_stall & __SIG_irq_trigger;

ms_reg	WB_reg(
	.i_clk(clk),
	.i_nrst(nrst),
	.i_en(1'b0),
	.i_data(regMM_out[0]),
	.o_data(regWB_out)
	);
	defparam	WB_reg.DATA_WIDTH = 1;
	defparam	WB_reg.REGNAME = "WB";

endmodule
