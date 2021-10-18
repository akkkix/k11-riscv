module mem(
	input	clk,
	input	rst,
	input	[1:0]wsize_i,

	input	[31:0]addr_i,
	input	[31:0]data_i,
	input	data_strobe_i,

	output	[31:0]addr_o,
	output	[31:0]data_o,
	output	data_strobe_o
);

endmodule
