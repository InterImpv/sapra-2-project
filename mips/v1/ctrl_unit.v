module ctrl_unit(
    i_instr_code,
    o_reg_dst,
    o_reg_wr,
    o_extend,
    o_alu_src,
    o_alu_op,
    o_beq,
    o_bne,
    o_jump,
    o_jmp_reg,
    o_mem_reg,
    o_mem_wr,
    o_mem_rd
    );

localparam
RTYPE = 6'b000000,
ADDIU = 6'b001000,
ADDI  = 6'b001001,
ANDI  = 6'b001100,
ORI   = 6'b001101,
XORI  = 6'b001110,
BEQ   = 6'b000100,
BNE   = 6'b000101,
JUMP  = 6'b000010,
JAL   = 6'b000011,
JR    = 6'b100000,   // work around MARS trickery; be careful, should be RTYPE
LUI   = 6'b001111,   // work around MARS trickery; used only to clear a register
SW    = 6'b101011,
LW    = 6'b100011;

input      [5:0] i_instr_code;
output reg [2:0] o_alu_op;
output reg [1:0] o_reg_dst;
output reg       o_reg_wr;
output reg       o_extend;
output reg       o_alu_src;
output reg       o_beq;
output reg       o_bne;
output reg       o_jump;
output reg       o_jmp_reg;
output reg [1:0] o_mem_reg;
output reg       o_mem_wr;
output reg       o_mem_rd;

always @* begin
    case (i_instr_code)
        RTYPE: begin
            o_reg_dst <= 2'b01;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b010;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        ADDI,
        ADDIU: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b111;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        LUI,
        ANDI: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b100;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        ORI: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b101;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        XORI: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b110;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        BEQ: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b001;
            o_beq     <= 1'b1;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        BNE: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b001;
            o_beq     <= 1'b0;
            o_bne     <= 1'b1;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        JUMP: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b001;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b1;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        JAL: begin
            o_reg_dst <= 2'b10;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b001;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b1;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b10;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        JR: begin
            o_reg_dst <= 2'b01;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b010;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b1;
            o_jmp_reg <= 1'b1;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        LW: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b011;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b01;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b1;
        end
        SW: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b1;
            o_alu_op  <= 3'b011;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b1;
            o_mem_rd  <= 1'b0;
        end
		  
        default: begin
            o_reg_dst <= 2'b00;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b0;
            o_alu_op  <= 3'b000;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_jmp_reg <= 1'b0;
            o_mem_reg <= 2'b00;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
    endcase
end

endmodule
