module constant_32b
#(parameter DATA_WIDTH=32, parameter VALUE=0)
(
	output [DATA_WIDTH-1:0] o_value
);

reg [DATA_WIDTH-1:0] value;
assign o_value = value;

initial begin
    value <= VALUE;
end
endmodule