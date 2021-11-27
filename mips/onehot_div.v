module one_hot_div(i_clk, i_nrst, o_clk);

input  i_clk;
input  i_nrst;
output o_clk;

parameter   DIV_CONST = 7;
parameter   DUTY = 3;

reg     [DIV_CONST-1:0] one_hot_cnt;

wire    sys_clk     = i_clk;
wire    sys_rst_n   = i_nrst;

assign o_clk = one_hot_cnt[0];

always @(posedge sys_clk, negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        one_hot_cnt <= DUTY;
    end else begin
        one_hot_cnt <= {one_hot_cnt[DIV_CONST-2:0], one_hot_cnt[DIV_CONST-1]};
    end
end

endmodule