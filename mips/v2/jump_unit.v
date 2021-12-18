module jump_unit(
    i_zero,
    i_jump,
    i_beq,
    i_bne,
    o_pc_src,
    o_kill1,
    o_kill2
);

input i_zero, i_jump, i_beq, i_bne;
output [1:0] o_pc_src;
output o_kill1, o_kill2;

wire branch, jump;

assign branch = ( (i_beq & i_zero) | (i_bne & ~i_zero) );
assign jump = i_jump & ~branch;
assign o_kill1 = i_jump | branch;
assign o_kill2 = branch;

assign o_pc_src = ({branch, jump});

/*always @*
    $display("->pc_src: %b", o_pc_src);
    
always @(posedge o_kill1)
    $display("\t^kill 1: %b", o_kill1);
    
always @(posedge o_kill2)
    $display("\t^kill 2: %b", o_kill2);*/

endmodule
