module vector_rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=4, parameter CELLS=16)
(
	input      [ADDR_WIDTH-1:0] i_addr,
	output reg [DATA_WIDTH-1:0] o_data
);

reg [DATA_WIDTH-1:0] data[CELLS-1:0];
initial $readmemh("_vector_table.dat", data);

initial begin : __DEBUG_VEC_CONTENTS
    integer i;
    $display("\t\tVECTORS:");
    for (i = 0; i < CELLS-1; i = i + 1)
        $display("@0x%h [%d] =\t %h", i, i, data[i]);
end

always @*
    o_data <= data[i_addr];
    
endmodule
