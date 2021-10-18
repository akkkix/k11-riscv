`default_nettype none

module register_cell(
	clk,
	rst,
	din,
	we,
	dout
);
	input clk;	
	input rst;
	input [31:0] din;
	input we;
	output [31:0] dout;

	reg [31:0] data_r;
	assign dout = data_r;

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			data_r <= 32'b0;
		end else begin
			if(we) begin
				data_r <= din;
			end
		end
	end

endmodule
