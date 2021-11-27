module redge_detect
(
    input   i_clk,
    input   i_sig,
    output  o_trig
);

reg trig;

assign o_trig = i_sig & ~trig;

always @(posedge i_clk) begin
    trig <= i_sig;
end
  
endmodule
