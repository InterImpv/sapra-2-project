module base_timer(i_clk, i_nrst, i_srst, i_en, i_we, i_data, o_trig, o_data);

parameter MAX_VAL = 255;
parameter WIDTH   = 16;

input               i_clk, i_nrst, i_srst;
input               i_en, i_we;

output  reg         o_trig;

input   [WIDTH-1:0] i_data;
output  [WIDTH-1:0] o_data;

reg     [WIDTH-1:0] ovf;
reg     [WIDTH-1:0] cnt;

wire    cnt_overflow = ((ovf == cnt) & i_en);

assign  o_data = cnt;

always @(posedge i_clk, negedge i_nrst) begin
    if(~i_nrst) begin
        o_trig <= 1'b0;
    end else begin
        if (cnt_overflow)
            o_trig <= 1'b1;
        else
            o_trig <= 1'b0;
    end
end

always @(posedge i_clk, negedge i_nrst) begin
    if(~i_nrst) begin
        cnt <= 0;
    end else begin
        if (cnt_overflow | i_srst)
            cnt <= 0;
        else if (i_en)
            cnt <= cnt + 1'b1;
    end
end

always @(posedge i_clk, negedge i_nrst) begin
    if(~i_nrst) begin
        ovf <= 0;
    end else begin
        if (i_srst)
            ovf <= 0;
        else if (i_we) begin
            ovf <= i_data;
            cnt <= 0;
        end
    end
end

endmodule
