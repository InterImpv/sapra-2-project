module proc_count(i_clk, i_nrst, i_en, i_pc, o_pc);

input             i_clk, i_nrst, i_en;
input      [31:0] i_pc;
output reg [31:0] o_pc;

always @(posedge i_clk, negedge i_nrst) begin
    if (~i_nrst)
        o_pc <= 32'd0;
    else begin
        if (~i_en)
            o_pc <= {i_pc[31:2], 2'b00};
    end
end

always @(posedge i_clk)
    $display("$pc:\t%h -> %h", o_pc, (o_pc - 4));

endmodule
