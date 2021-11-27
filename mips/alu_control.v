module alu_control(i_alu_op, i_func, o_alu_ctrl);

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

localparam
FUNC_ADDU = 6'b100001,
FUNC_SUBU = 6'b100011,
FUNC_AND  = 6'b100100,
FUNC_OR   = 6'b100101,
FUNC_XOR  = 6'b100110,
FUNC_NOR  = 6'b100111,
FUNC_SLL  = 6'b000000,
FUNC_SRL  = 6'b000010,
FUNC_SLTU = 6'b101011;

localparam
OP_NONE = 3'b000,
OP_JUMP = 3'b001,
OP_RTYP = 3'b010,
OP_MEMR = 3'b011,
OP_ANDI = 3'b100,
OP_ORRI = 3'b101,
OP_XORI = 3'b110;

input       [2:0]   i_alu_op;
input       [5:0]   i_func;
output  reg [3:0]   o_alu_ctrl;

always @* begin	 
    case (i_alu_op)
        OP_NONE: o_alu_ctrl <= CTRL_ADD;
        OP_JUMP: o_alu_ctrl <= CTRL_SUB;
        OP_RTYP: begin
            case (i_func)
                FUNC_ADDU: o_alu_ctrl <= CTRL_ADD;
                FUNC_SUBU: o_alu_ctrl <= CTRL_SUB;
                FUNC_AND:  o_alu_ctrl <= CTRL_AND;
                FUNC_OR:   o_alu_ctrl <= CTRL_OR;
                FUNC_XOR:  o_alu_ctrl <= CTRL_XOR;
                FUNC_NOR:  o_alu_ctrl <= CTRL_NOR;
                FUNC_SLL:  o_alu_ctrl <= CTRL_SLL;
                FUNC_SRL:  o_alu_ctrl <= CTRL_SRL;
                FUNC_SLTU: o_alu_ctrl <= CTRL_SLTU;
					 
                default: o_alu_ctrl <= CTRL_ADD;
            endcase
        end
        
        // immediate opcodes
        OP_ANDI: o_alu_ctrl <= CTRL_AND;
        OP_ORRI: o_alu_ctrl <= CTRL_OR;
        OP_XORI: o_alu_ctrl <= CTRL_XOR;
		  
        default: o_alu_ctrl <= CTRL_ADD;
    endcase
end
  
endmodule
