module regfile(i_clk, 
               i_nrst,
               i_raddr1, 
               i_raddr2, 
               i_waddr, 
               i_wdata, 
               i_we,
               o_rdata1,
               o_rdata2 
               );
               
input             i_clk, i_nrst, i_we;
input      [4:0]  i_raddr1, i_raddr2, i_waddr;
input      [31:0] i_wdata;           
output reg [31:0] o_rdata1, o_rdata2;

reg [31:0] gp_regs [31:0];

always @* begin
    o_rdata1 <= gp_regs[i_raddr1];
    o_rdata2 <= gp_regs[i_raddr2];
    end

always @(posedge i_clk) begin
    if (i_we & (i_waddr != 5'd0))
        gp_regs[i_waddr] <= i_wdata;
end

always @(negedge i_nrst) begin : __N_RESET
    integer i;
    for(i = 0; i < 32; i = i + 1)
        gp_regs[i] = 32'd0;
end

always @(posedge i_clk) begin : __DEBUG_REGFILE
    integer i;
    
    $display("\n\t\tREGISTERS");
    for (i = 0; i < 32; i = i + 2)
        $display("$[%d] 0x%h,\t$[%d]\t%h", i, gp_regs[i], i + 1, gp_regs[i + 1]);
    
    /*// zero & at
    $display("$zero\t%h,\t$at\t%h", gp_regs[0], gp_regs[1]);
    // v0-v1
    $display("$v0\t%h,\t$v1\t%h", gp_regs[2], gp_regs[3]);
    // a0-a3
    $display("$a0\t%h,\t$a1\t%h", gp_regs[4], gp_regs[5]);
    $display("$a2\t%h,\t$a3\t%h", gp_regs[6], gp_regs[7]);
    // t0-t3
    $display("$t0\t%h,\t$t1\t%h", gp_regs[8], gp_regs[9]);
    $display("$t2\t%h,\t$t3\t%h", gp_regs[10], gp_regs[11]);*/
    
    $display("");
end
  
endmodule
