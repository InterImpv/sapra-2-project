`timescale 1ns/1ps
module testbench;

parameter PERIOD = 20;

reg 
    clk,
    nrst_pc,
    nrst_regs;
    
wire
    kill_1,
    kill_2,
    stall;
    
wire [1:0]
    forw_A,
    forw_B;
    
wire [31:0]
    curr_rom_val;
    
integer i, time_step;

main_datapath MIPS_PIPELINE2(
    .i_clk          (clk),
    .i_nrst_pc      (nrst_pc),
    .i_nrst_regs    (nrst_regs),
    .o_curr_rom_out (curr_rom_val),
    .o_forwardA     (forw_A),
    .o_forwardB     (forw_B),
    .o_kill1        (kill_1),
    .o_kill2        (kill_2),
    .o_stall        (stall)
);

/* clock and format */
initial begin : __CLOCK_CYCLE
    i = 0;
    time_step = 0;
    
	clk = 0;
	forever #(PERIOD / 2) clk = ~clk;
end

always @(posedge clk) begin
    i = i + 1;
    time_step = time_step + 20;
    
    $display("*-----------------------------------------------------------------* TICK: %d -> STEPS: %d", i, time_step);
end

/* resets */
initial begin
	nrst_pc = 0;
	nrst_regs = 0;

	#2 nrst_pc = 1;
	nrst_regs = 1;
end

endmodule
