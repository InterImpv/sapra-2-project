module alu(i_opA, i_opB, i_control, i_shift, o_result, o_zf);

localparam
CTRL_ADD  = 4'd0,
CTRL_SUB  = 4'd1,
CTRL_AND  = 4'd2,
CTRL_OR   = 4'd3,
CTRL_NOR  = 4'd4,
CTRL_XOR  = 4'd5,
CTRL_SLL  = 4'd6,
CTRL_SRL  = 4'd7,
CTRL_SLTU = 4'd8;
  
input      [31:0] i_opA, i_opB;
input      [3:0]  i_control;
input      [4:0]  i_shift;
output reg [31:0] o_result;
output            o_zf;

assign o_zf = (o_result == 32'd0);

reg [3:0] control;

always @* begin
    control <= i_control;

    case (control)
        CTRL_AND: o_result <= i_opA & i_opB;
        CTRL_OR:  o_result <= i_opA | i_opB;
        CTRL_NOR: o_result <= ~(i_opA | i_opB);
        CTRL_XOR: o_result <= i_opA ^ i_opB;
        
        CTRL_ADD: o_result <= i_opA + i_opB;
        CTRL_SUB: o_result <= i_opA - i_opB;
        
        CTRL_SLTU: o_result <= (i_opA < i_opB) ? 32'd1 : 32'd0;
        
        CTRL_SLL: o_result = i_opB << i_shift;
        CTRL_SRL: o_result = i_opB >> i_shift;
		  
        default: o_result <= i_opA + i_opB;
        
    endcase
end

/*
always @* begin : __ALU_RES_DEBUG
    $display("\tALU CTRL:\t%b", i_control);
    $display("\tALU A:\t%h", i_opA);
    $display("\tALU B:\t%h", i_opB);
    $display("\tALU RES:\t%h", i_opB);
end*/

endmodule

