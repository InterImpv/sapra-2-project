module alu(i_opA, i_opB, i_control, i_shift, o_result, o_zf);

localparam
AND =  4'b0000, OR =  4'b0001,
ADD =  4'b0010, SUB = 4'b0110,
SOLT = 4'b0111, NOR = 4'b1100,
SLL  = 4'b1000, SRL = 4'b1111;
  
input      [31:0] i_opA, i_opB;
input      [3:0]  i_control;
input      [4:0]  i_shift;
output reg [31:0] o_result;
output            o_zf;

assign o_zf = (o_result == 32'd0);

always @* begin
    case (i_control)
        AND: o_result <= i_opA & i_opB;
        OR:  o_result <= i_opA | i_opB;
        NOR: o_result <= ~(i_opA | i_opB);
        
        ADD: o_result <= i_opA + i_opB;
        SUB: o_result <= i_opA - i_opB;
        
        SOLT: begin
            if (i_opA < i_opB)
                o_result <= 32'd1;
            else
                o_result <= 32'd0;
        end
        SLL: o_result = i_opB << i_shift;
        SRL: o_result = i_opB >> i_shift;
        
    endcase
end
endmodule
