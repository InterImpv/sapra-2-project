
module led_driver(
	input i_clk, i_nrst, i_we,
	input [4:0] i_addr,
	input [7:0] i_data,
	output [9:0] o_instr
);

reg [3:0] state;

always @(posedge i_clk)
    if (i_we)
        data[i_addr] <= i_data;
    else if (i_oe)
        o_data <= data[i_addr];

endmodule
