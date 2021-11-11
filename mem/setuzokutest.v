module fetch(
    input clk,
    input rst,
    
    // master port
    //output  [7:0] m_data,
    output        valid_ro,
    input       ready_i,

    output [31:0] pc_ro,

    input [31:0] branch_addr_i,
    input branch_taken_i
);
endmodule
module execute(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input       valid_i,
    output       ready_o,
    
    // master port
    //output  [7:0] m_data,
    output        valid_ro,
    input       ready_i,

    input [31:0] pc_i,
    input [31:0] inst_i,
    input [31:0] r0data_i,
    input [31:0] r1data_i,

    output [31:0] pc_ro,
    output [31:0] inst_ro,
    output [31:0] r0data_ro,
    output [31:0] r1data_ro,
    output [31:0] result_ro,
    
    output wire [31:0] jumpaddr_o,
    output wire jumptaken_o,

    output wire [31:0] datamemaddr_o, 
    output wire [31:0] datamemdata_o,
    output wire datamemwrite_o,
    output wire [1:0] datamemwidth_o

);
endmodule
module insm(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input         valid_i,
    output       ready_o,
    
    // master port
    //output  [7:0] m_data,
    output        valid_ro,
    input       ready_i,

    input [31:0] pc_i,
    output [31:0] pc_ro,

    output [31:0] insmemaddr_o,
    input [31:0] insmemdata_i,

    output [31:0] inst_o,

    input jump_taken_i
);
endmodule

module decode(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  valid_i,
    output ready_o,
    
    // master port
    //output  [7:0] m_data,
    output valid_ro,
    input  ready_i,

    output [4:0] r0num_o,
    output r0valid_o,
    output [4:0] r1num_o,
    output r1valid_o,
    output [4:0] rdnum_o,
    output rdreserve_o,
    input [31:0] r0data_i,
    input [31:0] r1data_i,
    input rsreserved_i,

    input [31:0] pc_i,
    input [31:0] inst_i,

    output [31:0] pc_ro,
    output [31:0] inst_ro,
    output [31:0] r0data_ro,
    output [31:0] r1data_ro,

    input jump_taken_i
);
endmodule
module datam(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input         valid_i,
    output       ready_o,
    
    // master port
    //    [7:0] m_data,
    output        valid_ro,
    input        ready_i,

    input [31:0] pc_i,
    input [31:0] inst_i,
    input [31:0] r0data_i,
    input [31:0] r1data_i,
    input [31:0] result_i,

    output [31:0] pc_ro,
    output [31:0] inst_ro,
    output [31:0] r0data_ro,
    output [31:0] r1data_ro,
    output [31:0] result_ro,

    input [31:0] datamemdata_i
);
endmodule

module writeback(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input        valid_i,
    output       ready_o,
    
    // master port
    //output  [7:0] m_data,
    //output        valid_ro,
    //input  wire       ready_i,

    input [31:0] pc_i,
    input [31:0] inst_i,
    input [31:0] r0data_i,
    input [31:0] r1data_i,
    input [31:0] result_i,

    output rdvalid_o,
    output [4:0] rdnum_o,
    output [31:0] rddata_o
);
  
endmodule
module insrom(
  input clk,
  input [31:0] addr,
  output [31:0] dout
);
endmodule

module dataram(
  input clk,
  input [31:0] addr,
  input [1:0] width,
  input write,
  input [31:0] din,
  output [31:0] dout
);
endmodule 

module register_file(
	input clk,
	input rst,
	
	input [4:0] r0_i,
	input r0v_i,
	input [4:0] r1_i,
	input r1v_i,
	output [31:0] r_opr0_o,
	output [31:0] r_opr1_o,
	output reserved_flg_o,

	input [4:0] rd_i,
	input reserve_flg_i,

	input wb_i,
	input [4:0] wb_r_i,
	input [31:0] result_i
);

endmodule
module core_tb(
    input clk,
    input rst
);

wire [31:0] fet_pcro;
wire fet_valid;
wire insm_ready;
wire insm_valid;
wire [31:0] insm_pcro;
wire [31:0] insm_insmemaddr_o;
wire [31:0] insm_inst;
wire [31:0] insr_dout;

wire decode_ready;
wire decode_valid;
wire [4:0] decode_r0num;
wire [4:0] decode_r1num;
wire [4:0] decode_rdnum;
wire decode_r0valid;
wire decode_r1valid;
wire decode_rdreserve;
wire [31:0] decode_pc;
wire [31:0] decode_inst;
wire [31:0] decode_r0data;
wire [31:0] decode_r1data;

wire [31:0] regfile_r_opr0;
wire [31:0] regfile_r_opr1;
wire regfile_reserved_flg;

wire execute_ready;
wire execute_valid;
wire [31:0] execute_pc;
wire [31:0] execute_inst;
wire [31:0] execute_r0data;
wire [31:0] execute_r1data;
wire [31:0] execute_result;
wire [31:0] execute_jumpaddr;
wire execute_jumptaken;
wire [31:0] execute_datamemaddr;
wire [31:0] execute_datamemdata;
wire execute_datamemwrite;
wire [1:0] execute_datamemwidth;

wire datam_ready;
wire datam_valid;
wire [31:0] datam_pc;
wire [31:0] datam_inst;
wire [31:0] datam_r0data;
wire [31:0] datam_r1data;
wire [31:0] datam_result;

wire [31:0] dataram_data;

wire writeback_ready;
wire writeback_rdvalid;
wire [4:0] writeback_rdnum;
wire [31:0] writeback_rddata;

fetch fet(
    .clk(clk),
    .rst(rst),

    .valid_ro(fet_valid),
    .ready_i(insm_ready),

    .pc_ro(fet_pcro),

    .branch_addr_i(execute_jumpaddr),
    .branch_taken_i(execute_jumptaken)
);

insm insm(
    .clk(clk),
    .rst(rst),

    .valid_i(fet_valid),
    .ready_o(insm_ready),
    
    .valid_ro(insm_valid),
    .ready_i(decode_ready),

    .pc_i(fet_pcro),
    .pc_ro(insm_pcro),

    .insmemaddr_o(insm_insmemaddr_o),
    .insmemdata_i(insr_dout),

    .inst_o(insm_inst),
    .jump_taken_i(execute_jumptaken)
);

insrom insr(
    .clk(clk),
    .addr(fet_pcro),
    .dout(insr_dout)
);



decode decode(
    .clk(clk),
    .rst(rst),

    .valid_i(insm_valid),
    .ready_o(decode_ready),

    .valid_ro(decode_valid),
    .ready_i(execute_ready),

    .r0num_o(decode_r0num),
    .r0valid_o(decode_r0valid),
    .r1num_o(decode_r1num),
    .r1valid_o(decode_r1valid),
    .rdnum_o(decode_rdnum),
    .rdreserve_o(decode_rdreserve),
    .r0data_i(regfile_r_opr0),
    .r1data_i(regfile_r_opr1),
    .rsreserved_i(regfile_reserved_flg),

    .pc_i(insm_pcro),
    .inst_i(insm_inst),

    .pc_ro(decode_pc),
    .inst_ro(decode_inst),
    .r0data_ro(decode_r0data),
    .r1data_ro(decode_r1data),

    .jump_taken_i(execute_jumptaken)
);



register_file regfile(
    .clk(clk),
    .rst(rst),
    .r0_i(decode_r0num),
    .r0v_i(decode_r0valid),
    .r1_i(decode_r1num),
    .r1v_i(decode_r1valid),
    .r_opr0_o(regfile_r_opr0),
    .r_opr1_o(regfile_r_opr1),
    .reserved_flg_o(regfile_reserved_flg),

    .rd_i(decode_rdnum),
    .reserve_flg_i(decode_rdreserve),

    .wb_i(writeback_rdvalid),
    .wb_r_i(writeback_rdnum),
    .result_i(writeback_rddata)
);



execute execute(
    .clk(clk),
    .rst(rst),

    .valid_i(decode_valid),
    .ready_o(execute_ready),
    
    .valid_ro(execute_valid),
    .ready_i(datam_ready),

    .pc_i(decode_pc),
    .inst_i(decode_inst),
    .r0data_i(decode_r0data),
    .r1data_i(decode_r1data),

    .pc_ro(execute_pc),
    .inst_ro(execute_inst),
    .r0data_ro(execute_r0data),
    .r1data_ro(execute_r1data),
    .result_ro(execute_result),
    
    .jumpaddr_o(execute_jumpaddr),
    .jumptaken_o(execute_jumptaken),

    .datamemaddr_o(execute_datamemaddr), 
    .datamemdata_o(execute_datamemdata),
    .datamemwrite_o(execute_datamemwrite),
    .datamemwidth_o(execute_datamemwidth)
);



datam datam(
    .clk(clk),
    .rst(rst),

    .valid_i(execute_valid),
    .ready_o(datam_ready),

    .valid_ro(datam_valid),
    .ready_i(writeback_ready),

    .pc_i(execute_pc),
    .inst_i(execute_inst),
    .r0data_i(execute_r0data),
    .r1data_i(execute_r1data),
    .result_i(execute_result),

    .pc_ro(datam_pc),
    .inst_ro(datam_inst),
    .r0data_ro(datam_r0data),
    .r1data_ro(datam_r1data),
    .result_ro(datam_result),

    .datamemdata_i(dataram_data)
);


dataram dataram(
    .clk(clk),
    .addr(execute_datamemaddr),
    .width(execute_datamemwidth),
    .write(execute_datamemwrite),
    .din(execute_datamemdata),
    .dout(dataram_data)
);



writeback writeback(
    .clk(clk),
    .rst(rst),

    .valid_i(datam_valid),
    .ready_o(writeback_ready),
    
    .pc_i(datam_pc),
    .inst_i(datam_inst),
    .r0data_i(datam_r0data),
    .r1data_i(datam_r1data),
    .result_i(datam_result),

    .rdvalid_o(writeback_rdvalid),
    .rdnum_o(writeback_rdnum),
    .rddata_o(writeback_rddata)
);
    
endmodule

