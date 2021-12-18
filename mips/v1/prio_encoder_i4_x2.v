module prio_encoder_i4_x2(i_sig, o_zero, o_addr);

input      [3:0] i_sig;
output reg [1:0] o_addr;
output reg       o_zero;

always @(i_sig) begin
    casex(i_sig)
        4'b0001: begin
            o_addr = 2'b00;
            o_zero = 1'b0;
        end
        4'b001x: begin
            o_addr = 2'b01;
            o_zero = 1'b0;
        end
        4'b01xx: begin
            o_addr = 2'b10;
            o_zero = 1'b0;
        end
        4'b1xxx: begin
            o_addr = 2'b11;
            o_zero = 1'b0;
        end
		  
        default: begin
            o_addr = 2'b00;
            o_zero = 1'b1;
        end
    endcase
end

endmodule
