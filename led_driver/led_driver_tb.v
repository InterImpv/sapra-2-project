`timescale 1 ns / 10 ps

module led_driver_tb;

reg CLK, IR, RST;
wire IR_READY, LED_CLK, MOSI, CS;

localparam clk_period = 20;

led_driver led_driver_tb (.in_clk(CLK), .in_IR_START(IR), .in_rst(RST), 
.out_IR_READY(IR_READY), .out_LED_CLK(LED_CLK), .out_MOSI(MOSI), .out_CS(CS));

initial begin
IR <= 0;
RST <= 1;
#50 RST <= 0;
#100 IR <= 1;
#200 IR <= 0;
end

initial begin
CLK <= 0;
forever #(clk_period / 2) CLK = ~CLK;
end

initial #40000 $finish;

endmodule