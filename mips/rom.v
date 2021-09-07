module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input      [ADDR_WIDTH-1:0] i_addr,
	output reg [DATA_WIDTH-1:0] o_data
);

reg [DATA_WIDTH-1:0] data[$pow(2, ADDR_WIDTH)-1:0];
initial $readmemh("_rom_init.dat", data);

initial begin : __DEBUG_ROM_CONTENTS
    integer i;
    $display("\t\tROM:");
    for (i = 0; i < $pow(2, ADDR_WIDTH); i = i + 1)
        $display("@0x%h [%d] =\t %h", i, i, data[i]);
end

always @*
    o_data <= data[i_addr];
    
always @(i_addr)
    $display("accs_rom @0x%h | 0x%h [%d]=\t %h", i_addr, {i_addr, 2'b00}, i_addr, data[i_addr]);
    
endmodule
