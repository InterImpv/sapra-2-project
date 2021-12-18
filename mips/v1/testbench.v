`timescale 1ns / 1ps

module testbench;

reg clk;
reg rst_key;
reg int1;
reg int2;
reg int3;

wire [31:0] curr_pc;
wire [31:0] instruction;
wire [3:0] mem_block_num;
wire [3:0] irq_addr;
wire [1:0] irq_num;
wire [1:0] pc_src;
wire [3:0] sig_jumps;
wire [3:0] lines;
wire clk_2;
wire stall;
wire [2:0] led_out;
wire jump_reg;
wire [1:0] reg_dst;
wire [1:0] mem_reg;
wire [31:0] regfile_wdata;
wire [31:0] regfile_a;
wire [15:0] irq_sig;

sapra_mips_graph_v1 test_mips(
	.CLOCK_50      (clk),
	.KEY           (rst_key),
	.INSTR         (instruction),
	.CURR_PC       (curr_pc),
	.IRQ_ADDR      (irq_addr[3:0]),
	.IRQ_NUM       (irq_num[1:0]),
	.MEM_BLOCK_WR  (mem_block_num),
	.__SIG_PC_SRC  (pc_src),
	.__SIG_JUMPS   (sig_jumps),
	.__LINES       (lines),
	.__STALL       (stall),
	.GPIO_1        (led_out),
	.IRQ_SIG       (irq_sig),
	.HEX0          (),
	.HEX1          (),
	.HEX2          (),
	.HEX3          (),
	.HEX4          (),
	.HEX5          (),
	.HEX6          (),
	.HEX7          ()
);
                          
/* control signals */
initial begin
    clk = 1'b1;
    forever #20 clk = ~clk;
end

initial begin
    rst_key = 1'b0;
    #10 rst_key = 1'b1;
end

initial begin
    int1 = 1'b0;
end

initial begin
    int2 = 1'b0;
end

initial begin
    int3 = 1'b0;
end

endmodule
