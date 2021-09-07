module mux_i2_x1(i_data0, i_data1, i_control, o_data);

parameter DATA_WIDTH = 32;

input                  i_control;
input      [DATA_WIDTH-1:0] i_data0, i_data1; 
output reg [DATA_WIDTH-1:0] o_data;

always @* begin
    case (i_control)
        1'b0: o_data <= i_data0;
        1'b1: o_data <= i_data1;
        
        default: o_data <= {DATA_WIDTH{1'bZ}};
    endcase
end
  
endmodule
