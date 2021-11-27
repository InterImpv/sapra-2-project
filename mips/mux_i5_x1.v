module mux_i5_x1(i_data0, i_data1, i_data2, i_data3, i_data4, i_control, o_data);

parameter DATA_WIDTH = 32;

input      [2:0]       i_control;
input      [DATA_WIDTH-1:0] i_data0, i_data1, i_data2, i_data3, i_data4; 
output reg [DATA_WIDTH-1:0] o_data;

always @* begin
    case (i_control)
        3'b000: o_data <= i_data0;
        3'b001: o_data <= i_data1;
        3'b010: o_data <= i_data2;
        3'b011: o_data <= i_data3;
        3'b100: o_data <= i_data4;
        
        default: o_data <= {DATA_WIDTH{1'bZ}};
    endcase
end
  
endmodule
