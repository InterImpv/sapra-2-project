module dec_i2_x4(i_we, i_addr, o_sig);

input               i_we;
input       [1:0]   i_addr;
output  reg [3:0]   o_sig;

always @* begin
    if (i_we) begin
        case (i_addr)
            2'b00: o_sig <= 4'b0001;
            2'b01: o_sig <= 4'b0010;
            2'b10: o_sig <= 4'b0100;
            2'b11: o_sig <= 4'b1000;
		  
		      default: o_sig <= 4'b0000;
        endcase
	     
	 end else begin
        o_sig <= 4'b0000;
    end
end

endmodule