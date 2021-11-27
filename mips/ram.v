module ram
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8, parameter CELLS=256)
(
	 input                         i_clk, i_we, i_oe,
    input      [(ADDR_WIDTH-1):0] i_addr,
    input      [(DATA_WIDTH-1):0] i_data,
    output reg [(DATA_WIDTH-1):0] o_data
);

reg [DATA_WIDTH-1:0] data[CELLS-1:0];
//initial $readmemh("_ram_init.dat", data);

/*
always @* begin
    o_data <= data[i_addr];
end*/

always @(posedge i_clk)
    if (i_we)
        data[i_addr] <= i_data;
    else if (i_oe)
        o_data <= data[i_addr];

/*
always @(posedge i_clk) begin : __DEBUG_RAM_CONTENTS
    integer i;
    $display("\t\tRAM:");
    for (i = 0; i < 32-1; i = i + 1)
        $display("@[%d] 0x%h =\t %h", i, i, data[i]);
    
    $display("");
end*/

endmodule
