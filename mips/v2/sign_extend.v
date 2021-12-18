module sign_extend(i_data, i_en, o_data);

input	i_en;
input   [15:0]  i_data;
output  [31:0]  o_data;

reg [31:0] data;

assign o_data = data;

always @* begin
    if (i_en)
        data <= { { 16{i_data[15]} }, i_data };
    else
        data <= { 16'd0, i_data };
end

endmodule
