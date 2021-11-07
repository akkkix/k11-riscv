`default_nettype none
`include "./reg/register_cell.v"

module register_file(
	clk,
	rst,
	r0_i,
	r0v_i,
	r1_i,
	r1v_i,
	r_opr0_o,
	r_opr1_o,
	reserved_flg_o,

	rd_i,
	reserve_flg_i,
	
	wb_i,
	wb_r_i,
	result_i
);
	input clk;
	input rst;
	
	input [4:0] r0_i;
	input r0v_i;
	input [4:0] r1_i;
	input r1v_i;
	output [31:0] r_opr0_o;
	output [31:0] r_opr1_o;
	output reserved_flg_o;

	input [4:0] rd_i;
	input reserve_flg_i;

	input wb_i;
	input [4:0] wb_r_i;
	input [31:0] result_i;

	reg [31:0] reserve_status;

	assign reserved_flg_o = ((reserve_status[r0_i] && r0v_i) || (reserve_status[r1_i] && r1v_i)) ? 1'b1 : 1'b0;
	
	assign r_opr0_o =
		(r0v_i == 1'b0) ? 32'hffffffff:
		(r0_i == 5'd0) ? data0 :
		(r0_i == 5'd1) ? data1 :
		(r0_i == 5'd2) ? data2 :
		(r0_i == 5'd3) ? data3 :
		(r0_i == 5'd4) ? data4 :
		(r0_i == 5'd5) ? data5 :
		(r0_i == 5'd6) ? data6 :
		(r0_i == 5'd7) ? data7 :
		(r0_i == 5'd8) ? data8 :
		(r0_i == 5'd9) ? data9 :
		(r0_i == 5'd10) ? data10 :
		(r0_i == 5'd11) ? data11 :
		(r0_i == 5'd12) ? data12 :
		(r0_i == 5'd13) ? data13 :
		(r0_i == 5'd14) ? data14 :
		(r0_i == 5'd15) ? data15 :
		(r0_i == 5'd16) ? data16 :
		(r0_i == 5'd17) ? data17 :
		(r0_i == 5'd18) ? data18 :
		(r0_i == 5'd19) ? data19 :
		(r0_i == 5'd20) ? data20 :
		(r0_i == 5'd21) ? data21 :
		(r0_i == 5'd22) ? data22 :
		(r0_i == 5'd23) ? data23 :
		(r0_i == 5'd24) ? data24 :
		(r0_i == 5'd25) ? data25 :
		(r0_i == 5'd26) ? data26 :
		(r0_i == 5'd27) ? data27 :
		(r0_i == 5'd28) ? data28 :
		(r0_i == 5'd29) ? data29 :
		(r0_i == 5'd30) ? data30 :
		(r0_i == 5'd31) ? data31 : 32'hffffffff;
	
	assign r_opr1_o =
		(r1v_i == 1'b0) ? 32'hffffffff:
		(r1_i == 5'd0) ? data0 :
		(r1_i == 5'd1) ? data1 :
		(r1_i == 5'd2) ? data2 :
		(r1_i == 5'd3) ? data3 :
		(r1_i == 5'd4) ? data4 :
		(r1_i == 5'd5) ? data5 :
		(r1_i == 5'd6) ? data6 :
		(r1_i == 5'd7) ? data7 :
		(r1_i == 5'd8) ? data8 :
		(r1_i == 5'd9) ? data9 :
		(r1_i == 5'd10) ? data10 :
		(r1_i == 5'd11) ? data11 :
		(r1_i == 5'd12) ? data12 :
		(r1_i == 5'd13) ? data13 :
		(r1_i == 5'd14) ? data14 :
		(r1_i == 5'd15) ? data15 :
		(r1_i == 5'd16) ? data16 :
		(r1_i == 5'd17) ? data17 :
		(r1_i == 5'd18) ? data18 :
		(r1_i == 5'd19) ? data19 :
		(r1_i == 5'd20) ? data20 :
		(r1_i == 5'd21) ? data21 :
		(r1_i == 5'd22) ? data22 :
		(r1_i == 5'd23) ? data23 :
		(r1_i == 5'd24) ? data24 :
		(r1_i == 5'd25) ? data25 :
		(r1_i == 5'd26) ? data26 :
		(r1_i == 5'd27) ? data27 :
		(r1_i == 5'd28) ? data28 :
		(r1_i == 5'd29) ? data29 :
		(r1_i == 5'd30) ? data30 :
		(r1_i == 5'd31) ? data31 : 32'hffffffff;

	wire we0 = (wb_i && wb_r_i == 5'd0) ? 1'b1 : 1'b0;
	wire we1 = (wb_i && wb_r_i == 5'd1) ? 1'b1 : 1'b0;
	wire we2 = (wb_i && wb_r_i == 5'd2) ? 1'b1 : 1'b0;
	wire we3 = (wb_i && wb_r_i == 5'd3) ? 1'b1 : 1'b0;
	wire we4 = (wb_i && wb_r_i == 5'd4) ? 1'b1 : 1'b0;
	wire we5 = (wb_i && wb_r_i == 5'd5) ? 1'b1 : 1'b0;
	wire we6 = (wb_i && wb_r_i == 5'd6) ? 1'b1 : 1'b0;
	wire we7 = (wb_i && wb_r_i == 5'd7) ? 1'b1 : 1'b0;
	wire we8 = (wb_i && wb_r_i == 5'd8) ? 1'b1 : 1'b0;
	wire we9 = (wb_i && wb_r_i == 5'd9) ? 1'b1 : 1'b0;
	wire we10 = (wb_i && wb_r_i == 5'd10) ? 1'b1 : 1'b0;
	wire we11 = (wb_i && wb_r_i == 5'd11) ? 1'b1 : 1'b0;
	wire we12 = (wb_i && wb_r_i == 5'd12) ? 1'b1 : 1'b0;
	wire we13 = (wb_i && wb_r_i == 5'd13) ? 1'b1 : 1'b0;
	wire we14 = (wb_i && wb_r_i == 5'd14) ? 1'b1 : 1'b0;
	wire we15 = (wb_i && wb_r_i == 5'd15) ? 1'b1 : 1'b0;
	wire we16 = (wb_i && wb_r_i == 5'd16) ? 1'b1 : 1'b0;
	wire we17 = (wb_i && wb_r_i == 5'd17) ? 1'b1 : 1'b0;
	wire we18 = (wb_i && wb_r_i == 5'd18) ? 1'b1 : 1'b0;
	wire we19 = (wb_i && wb_r_i == 5'd19) ? 1'b1 : 1'b0;
	wire we20 = (wb_i && wb_r_i == 5'd20) ? 1'b1 : 1'b0;
	wire we21 = (wb_i && wb_r_i == 5'd21) ? 1'b1 : 1'b0;
	wire we22 = (wb_i && wb_r_i == 5'd22) ? 1'b1 : 1'b0;
	wire we23 = (wb_i && wb_r_i == 5'd23) ? 1'b1 : 1'b0;
	wire we24 = (wb_i && wb_r_i == 5'd24) ? 1'b1 : 1'b0;
	wire we25 = (wb_i && wb_r_i == 5'd25) ? 1'b1 : 1'b0;
	wire we26 = (wb_i && wb_r_i == 5'd26) ? 1'b1 : 1'b0;
	wire we27 = (wb_i && wb_r_i == 5'd27) ? 1'b1 : 1'b0;
	wire we28 = (wb_i && wb_r_i == 5'd28) ? 1'b1 : 1'b0;
	wire we29 = (wb_i && wb_r_i == 5'd29) ? 1'b1 : 1'b0;
	wire we30 = (wb_i && wb_r_i == 5'd30) ? 1'b1 : 1'b0;
	wire we31 = (wb_i && wb_r_i == 5'd31) ? 1'b1 : 1'b0;

	wire [31:0] data0 = 32'd0;
	wire [31:0] data1;
	wire [31:0] data2;
	wire [31:0] data3;
	wire [31:0] data4;
	wire [31:0] data5;
	wire [31:0] data6;
	wire [31:0] data7;
	wire [31:0] data8;
	wire [31:0] data9;
	wire [31:0] data10;
	wire [31:0] data11;
	wire [31:0] data12;
	wire [31:0] data13;
	wire [31:0] data14;
	wire [31:0] data15;
	wire [31:0] data16;
	wire [31:0] data17;
	wire [31:0] data18;
	wire [31:0] data19;
	wire [31:0] data20;
	wire [31:0] data21;
	wire [31:0] data22;
	wire [31:0] data23;
	wire [31:0] data24;
	wire [31:0] data25;
	wire [31:0] data26;
	wire [31:0] data27;
	wire [31:0] data28;
	wire [31:0] data29;
	wire [31:0] data30;
	wire [31:0] data31;

	
	//register_cell r0(.clk(clk),.rst(rst),.din(result_i),.we(we0),.dout());
	register_cell r1(.clk(clk),.rst(rst),.din(result_i),.we(we1),.dout(data1));
	register_cell r2(.clk(clk),.rst(rst),.din(result_i),.we(we2),.dout(data2));
	register_cell r3(.clk(clk),.rst(rst),.din(result_i),.we(we3),.dout(data3));
	register_cell r4(.clk(clk),.rst(rst),.din(result_i),.we(we4),.dout(data4));
	register_cell r5(.clk(clk),.rst(rst),.din(result_i),.we(we5),.dout(data5));
	register_cell r6(.clk(clk),.rst(rst),.din(result_i),.we(we6),.dout(data6));
	register_cell r7(.clk(clk),.rst(rst),.din(result_i),.we(we7),.dout(data7));
	register_cell r8(.clk(clk),.rst(rst),.din(result_i),.we(we8),.dout(data8));
	register_cell r9(.clk(clk),.rst(rst),.din(result_i),.we(we9),.dout(data9));
	register_cell r10(.clk(clk),.rst(rst),.din(result_i),.we(we10),.dout(data10));
	register_cell r11(.clk(clk),.rst(rst),.din(result_i),.we(we11),.dout(data11));
	register_cell r12(.clk(clk),.rst(rst),.din(result_i),.we(we12),.dout(data12));
	register_cell r13(.clk(clk),.rst(rst),.din(result_i),.we(we13),.dout(data13));
	register_cell r14(.clk(clk),.rst(rst),.din(result_i),.we(we14),.dout(data14));
	register_cell r15(.clk(clk),.rst(rst),.din(result_i),.we(we15),.dout(data15));
	register_cell r16(.clk(clk),.rst(rst),.din(result_i),.we(we16),.dout(data16));
	register_cell r17(.clk(clk),.rst(rst),.din(result_i),.we(we17),.dout(data17));
	register_cell r18(.clk(clk),.rst(rst),.din(result_i),.we(we18),.dout(data18));
	register_cell r19(.clk(clk),.rst(rst),.din(result_i),.we(we19),.dout(data19));
	register_cell r20(.clk(clk),.rst(rst),.din(result_i),.we(we20),.dout(data20));
	register_cell r21(.clk(clk),.rst(rst),.din(result_i),.we(we21),.dout(data21));
	register_cell r22(.clk(clk),.rst(rst),.din(result_i),.we(we22),.dout(data22));
	register_cell r23(.clk(clk),.rst(rst),.din(result_i),.we(we23),.dout(data23));
	register_cell r24(.clk(clk),.rst(rst),.din(result_i),.we(we24),.dout(data24));
	register_cell r25(.clk(clk),.rst(rst),.din(result_i),.we(we25),.dout(data25));
	register_cell r26(.clk(clk),.rst(rst),.din(result_i),.we(we26),.dout(data26));
	register_cell r27(.clk(clk),.rst(rst),.din(result_i),.we(we27),.dout(data27));
	register_cell r28(.clk(clk),.rst(rst),.din(result_i),.we(we28),.dout(data28));
	register_cell r29(.clk(clk),.rst(rst),.din(result_i),.we(we29),.dout(data29));
	register_cell r30(.clk(clk),.rst(rst),.din(result_i),.we(we30),.dout(data30));
	register_cell r31(.clk(clk),.rst(rst),.din(result_i),.we(we31),.dout(data31));

	always @(posedge clk or posedge rst) begin
		if(rst) begin
			reserve_status <= 32'b0;
		end else begin
			if(reserve_flg_i) begin
				reserve_status[rd_i] <= 1'b1;
			end
			if (wb_i) begin
				reserve_status[wb_r_i] <= 1'b0;
			end

		end
	end
	
	
endmodule
