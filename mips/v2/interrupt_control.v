module interrupt_control
#(parameter DATA_WIDTH=32)	// data width should be at least 16 bits wide
(
    input      	i_clk, i_we, i_nrst, i_trig,
    input     	[3:0] i_irq,
    input      	[(DATA_WIDTH-1):0] i_data,
    output     	[(DATA_WIDTH-1):0] o_data
);

reg [DATA_WIDTH-1:0] data;


always @(posedge i_clk or negedge i_nrst) begin
    if(~i_nrst)
        data <= 0;
    else if (i_we)
        data <= i_data[15:0];
    else
    	if (i_trig)
	    data[15] <= 1'b1;
	    casex (i_irq)
		4'b0001: data[8]  <= 1'b1;
		4'b001x: data[9]  <= 1'b1;
		4'b01xx: data[10] <= 1'b1;
		4'b1xxx: data[11] <= 1'b1;
	    endcase
end
		  
assign o_data = data;

always @(posedge i_clk) begin : __DEBUG_INTERRUPT_CONTROL
    $display("\t\tINTERRUPT:\t>%b %b %b %b<", data[31:24], data[23:16], data[15:8], data[7:0]);
    $display(">PD: %b | EN: %b | IR: %b", data[15], data[3:0], data[11:8]);
    
    $display("");
end

endmodule
