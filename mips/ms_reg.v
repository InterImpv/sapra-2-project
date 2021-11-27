module ms_reg
#(parameter DATA_WIDTH=32, parameter REGNAME="defreg")
(
    input   i_clk,
    input   i_nrst,
    input   i_en,
    input   [DATA_WIDTH-1:0]  i_data,
    output  [DATA_WIDTH-1:0]  o_data
);

reg [DATA_WIDTH-1:0] data;

assign o_data = data;

always @(posedge i_clk or negedge i_nrst) begin
    if (~i_nrst)
	     data <= 0;
	 else if (~i_en)
        data <= i_data;
end

/*always @(posedge i_clk) begin : __DEBUG_MS_REG
    $display("$%s:\tp %h,\ts %h", REGNAME, primary_reg, secondary_reg);
end*/
/*
always @(posedge i_clk) begin : __DEBUG_SPECIFIC
    case(REGNAME)
        "INST",
        "A",
        "B",
        "R",
        "D",
        "BTA",
        "NPC":
            $display("\t$%s:\t\tp %h", REGNAME, data,);
    endcase
end*/
  
endmodule
