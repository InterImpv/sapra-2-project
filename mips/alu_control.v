module alu_control(i_alu_op, i_func, o_alu_ctrl);

localparam
AND =  4'b0000, OR =  4'b0001,
ADD =  4'b0010, SUB = 4'b0110,
SOLT = 4'b0111, NOR = 4'b1100,
SRL  = 4'b1111;

input       [1:0]   i_alu_op;
input       [5:0]   i_func;
output  reg [3:0]   o_alu_ctrl;

always @* begin
    case (i_alu_op)
        2'b00: o_alu_ctrl <= ADD;
        2'b01: o_alu_ctrl <= SUB;
        2'b10: begin
            case (i_func)
                6'b100000: o_alu_ctrl <= ADD;
                6'b100010: o_alu_ctrl <= SUB;
                6'b100100: o_alu_ctrl <= AND;
                6'b100101: o_alu_ctrl <= OR;
                6'b101010: o_alu_ctrl <= SOLT;
                6'b000010: o_alu_ctrl <= SRL;
            endcase
        end
        default: o_alu_ctrl <= ADD;
    endcase
end
  
endmodule
