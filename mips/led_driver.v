//Module for driving 32x8 LED matrix
//The module should be connected to MIPS CORE (CPU) for achieving the frames

module led_driver (
	input [15:0] in_data, 	//16-bit data input from processor (CPU)
	input [7:0] in_addr, 	//address for writing processor`s data
	input in_clk,			//processor`s clock
	input in_IR_START,			//interrupt from processor about starting to send the frame
	input in_we,			//write enable for processor
	input in_rst,			//reset
	output reg out_IR_READY,	//interrupt for processor about completing of sending the frame
	output reg out_LED_CLK,		//SPI clock for matrix
	output reg out_MOSI,		//SPI data for matrix
	output reg out_CS			//SPI chip select for matrix
);
			
reg [15:0] ram [131:0]; 	//internal module registers
reg [15:0] instr_buff; 	//frame buffer
reg [8:0] counter1;		//counter 1
reg [4:0] counter2; 	//counter 2
reg [2:0] state;		//state

initial $readmemb ("_led_driver_init.dat", ram);	//test frame

always @ (posedge in_clk) 	//writing to the RAM from CPU
	if (in_we)
		ram[in_addr] <= in_data;

always @ (posedge in_clk) 	//collecting instruction from the RAM
	instr_buff <= ram[counter1];

always @ (posedge in_clk, negedge in_rst) 	//data sending cycle (one cycle - one frame)
	begin
		if (~in_rst) begin
		state <= 3'b000;
		counter1 <= 0;
		counter2 <= 5'd16;
		out_LED_CLK <= 0;
		out_MOSI <= 0;
		out_CS <= 1;
		out_IR_READY <= 0;
		end
		else
			case (state)
			3'b000: begin
				out_IR_READY <= 1;
				if (in_IR_START) state <= 3'b001;
			end
			3'b001: begin
				out_IR_READY <= 0;
				if (counter1 < 8'd132) begin
				out_CS <= 0;
				state <= 3'b010;
				end
				else state <= 3'b111;
			end
			3'b010: begin
				if (counter2 > 5'd0) begin
				out_MOSI <= instr_buff[counter2-1'b1];
				state <= 3'b011;
				end
				else state <= 3'b101;
			end
			3'b011: begin
				out_LED_CLK <= 1;
				state <= 3'b100;
			end
			3'b100: begin
				out_LED_CLK <= 0;
				counter2 <= counter2 - 1;
				state <= 3'b010;
			end
			3'b101: begin
				counter2 <= 5'd16;
				out_CS <= 1;
				counter1 <= counter1 + 1;
				state <= 3'b001;
			end
			3'b111: begin
				counter1 <= 0;
				out_IR_READY <= 1;
				state <= 3'b000;
			end
			default: state <= 3'b000;
			endcase
	end

endmodule
