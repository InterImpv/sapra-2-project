module subtractor(i_opA, i_opB, o_result);
parameter DATA_WIDTH = 32;

input  [DATA_WIDTH-1:0] i_opA, i_opB;
output [DATA_WIDTH-1:0] o_result;

assign o_result = i_opA - i_opB;
  
endmodule
