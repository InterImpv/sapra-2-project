module mux_i3_x1(i_data0, i_data1, i_data2, i_control, o_data);

parameter DATA_WIDTH = 32;

input      [1:0]       i_control;
input      [DATA_WIDTH-1:0] i_data0, i_data1, i_data2; 
output reg [DATA_WIDTH-1:0] o_data;

always @* begin
    case (i_control)
        2'b00: o_data <= i_data0;
        2'b01: o_data <= i_data1;
        2'b10: o_data <= i_data2;
        
        default: o_data <= {DATA_WIDTH{1'bZ}};
    endcase
end
  
endmodule
