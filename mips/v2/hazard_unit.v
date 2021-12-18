module hazard_unit(
    i_reg_s,
    i_reg_t,
    i_reg_d_EX,
    i_reg_d_MM,
    i_reg_d_WB,
    i_reg_wr_EX,
    i_reg_wr_MM,
    i_reg_wr_WB,
    i_mem_rd_EX,
    o_forwardA,
    o_forwardB,
    o_stall
);

input [4:0] i_reg_s, i_reg_t;
input [4:0] i_reg_d_EX, i_reg_d_MM, i_reg_d_WB;
input i_reg_wr_EX, i_reg_wr_MM, i_reg_wr_WB, i_mem_rd_EX;
output reg [1:0] o_forwardA, o_forwardB;
output reg o_stall;

//check source
always @* begin
    if      ( (i_reg_s != 0) && (i_reg_s == i_reg_d_EX) && i_reg_wr_EX ) o_forwardA = 2'b01;
    else if ( (i_reg_s != 0) && (i_reg_s == i_reg_d_MM) && i_reg_wr_MM ) o_forwardA = 2'b10;
    else if ( (i_reg_s != 0) && (i_reg_s == i_reg_d_WB) && i_reg_wr_WB ) o_forwardA = 2'b11;
    else    o_forwardA = 2'b00;
end

//check target
always @* begin
    if      ( (i_reg_t != 0) && (i_reg_t == i_reg_d_EX) && i_reg_wr_EX ) o_forwardB = 2'b01;
    else if ( (i_reg_t != 0) && (i_reg_t == i_reg_d_MM) && i_reg_wr_MM ) o_forwardB = 2'b10;
    else if ( (i_reg_t != 0) && (i_reg_t == i_reg_d_WB) && i_reg_wr_WB ) o_forwardB = 2'b11;
    else    o_forwardB = 2'b00;
end

//RAW (generate stall signal)
always @* begin
    if ( i_mem_rd_EX && ( (o_forwardA == 2'b01) || (o_forwardB == 2'b01) ) )
    o_stall = 1'b1;
    else
    o_stall = 1'b0;
end

/*
always @(o_forwardA)
    $display("\t\t->forwarded A by %b", o_forwardA);
    
always @(o_forwardB)
    $display("\t\t->forwarded B by %b", o_forwardB);
    
always @(o_stall)
    $display("\tstall: %b", o_stall);*/

endmodule
