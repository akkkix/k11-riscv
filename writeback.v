`include "./inst_def.v"
`default_nettype none
module writeback(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  wire       valid_i,
    output wire       ready_o,
    
    // master port
    //output reg  [7:0] m_data,
    //output reg        valid_ro,
    //input  wire       ready_i,

    input wire [31:0] pc_i,
    input wire [31:0] inst_i,
    input wire [31:0] r0data_i,
    input wire [31:0] r1data_i,
    input wire [31:0] result_i,

    output wire rdvalid_o,
    output wire [4:0] rdnum_o,
    output wire [31:0] rddata_o
);

wire r_type = (
    opcode == BOP_OP 

) ? 1'b1 : 1'b0;
wire i_type = (
    opcode == BOP_OPIMM ||
    opcode == BOP_JALR ||
    opcode == BOP_LOAD 

) ? 1'b1 : 1'b0;
wire u_type = (
    opcode == BOP_LUI ||
    opcode == BOP_AUIPC 

) ? 1'b1 : 1'b0;
wire j_type = (
    opcode == BOP_JAL 

) ? 1'b1 : 1'b0;

// wire cke = ~valid_ro | ready_i;

// always @(posedge clk or posedge rst) begin
//     if(rst)begin
//         valid_ro <= 0;
//     end
//     else begin
//         if(cke) begin
//             valid_ro <= valid_i;
//         end
//     end
// end

// assign ready_o = cke;

assign rdvalid_o =  (r_type | i_type | u_type | j_type ) & valid_i;
assign rdnum_o = inst_i[`INST_RD];
assign rddata_o = result_i;

endmodule
`resetall