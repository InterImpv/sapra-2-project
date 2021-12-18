module simple_pwm (i_clk, i_en, i_dc, i_ovf, o_pwm);

parameter DATA_WIDTH=32;

input           i_clk;
input           i_en;
input   [DATA_WIDTH-1:0]  i_dc;
input   [DATA_WIDTH-1:0]  i_ovf;
output          o_pwm;

reg     [DATA_WIDTH-1:0]  cnt_ff  = 0;
reg     [DATA_WIDTH-1:0]  dc_ff   = 0;
reg     [DATA_WIDTH-1:0]  ovf_ff  = 0;
reg             out_ff  = 1'b1;
reg             en_ff   = 1'b1;

always @(posedge i_clk) begin
    en_ff <= i_en;
    dc_ff <= i_dc;
	 ovf_ff <= i_ovf;
end

always @(posedge i_clk)
    if(en_ff) begin
        cnt_ff <= cnt_ff + 1'b1;
		  
		  if(cnt_ff >= ovf_ff)
		      cnt_ff <= 32'd0;
	 end

always @(posedge i_clk)
    out_ff <= (cnt_ff < dc_ff);

assign o_pwm = out_ff;

endmodule