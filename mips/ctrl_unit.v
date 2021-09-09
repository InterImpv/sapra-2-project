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
    o_mem_reg,
    o_mem_wr,
    o_mem_rd
    );

localparam
RTYP = 6'b000000,
ADDIU = 6'b001001,
SOLT = 6'b101010,
BEQ  = 6'b000100, BNE = 6'b000101,
JUMP = 6'b000010,
SW   = 6'b101011, LW  = 6'b100011;

input [5:0] i_instr_code;
output reg [1:0] o_alu_op;
output reg  o_reg_dst;
output reg  o_reg_wr;
output reg  o_extend;
output reg  o_alu_src;
output reg  o_beq;
output reg  o_bne;
output reg  o_jump;
output reg  o_mem_reg;
output reg  o_mem_wr;
output reg  o_mem_rd;

always @* begin
    case (i_instr_code)
        RTYP: begin
            o_reg_dst <= 1'b1;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b0;
            o_alu_op  <= 2'b10;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        SOLT,
        ADDIU: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b0;
            o_alu_src <= 1'b1;
            o_alu_op  <= 2'b11;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        BEQ: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 2'b01;
            o_beq     <= 1'b1;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        BNE: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 2'b01;
            o_beq     <= 1'b0;
            o_bne     <= 1'b1;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        JUMP: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b0;
            o_alu_op  <= 2'b01;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b1;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b0;
        end
        LW: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b1;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b1;
            o_alu_op  <= 2'b11;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b1;
            o_mem_wr  <= 1'b0;
            o_mem_rd  <= 1'b1;
        end
        SW: begin
            o_reg_dst <= 1'b0;
            o_reg_wr  <= 1'b0;
            o_extend  <= 1'b1;
            o_alu_src <= 1'b1;
            o_alu_op  <= 2'b11;
            o_beq     <= 1'b0;
            o_bne     <= 1'b0;
            o_jump    <= 1'b0;
            o_mem_reg <= 1'b0;
            o_mem_wr  <= 1'b1;
            o_mem_rd  <= 1'b0;
        end
    endcase
end

endmodule
