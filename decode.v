`include "./inst_def.v"
`default_nettype none

module decode(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  wire valid_i,
    output wire ready_o,
    
    // master port
    //output reg  [7:0] m_data,
    output reg valid_ro,
    input  wire ready_i,

    output wire [4:0] r0num_o,
    output wire r0valid_o,
    output wire [4:0] r1num_o,
    output wire r1valid_o,
    output wire [4:0] rdnum_o,
    output wire rdreserve_o,
    input wire [31:0] r0data_i,
    input wire [31:0] r1data_i,
    input wire rsreserved_i,

    input wire [31:0] pc_i,
    input wire [31:0] inst_i,

    output reg [31:0] pc_ro,
    output reg [31:0] inst_ro,
    output reg [31:0] r0data_ro,
    output reg [31:0] r1data_ro

    //input wire branch_taken_i
);

`include "./opcode_def.v"

wire [6:0] opcode = inst_i[`INST_OPCODE];

wire r_type = (
    opcode == BOP_OP 

) ? 1'b1 : 1'b0;
wire i_type = (
    opcode == BOP_OPIMM ||
    opcode == BOP_JALR ||
    opcode == BOP_LOAD 

) ? 1'b1 : 1'b0;
wire s_type = (
    opcode == BOP_STORE 


) ? 1'b1 : 1'b0;
wire b_type = (
    opcode == BOP_BRANCH 

) ? 1'b1 : 1'b0;
wire u_type = (
    opcode == BOP_LUI ||
    opcode == BOP_AUIPC 

) ? 1'b1 : 1'b0;
wire j_type = (
    opcode == BOP_JAL 

) ? 1'b1 : 1'b0;

wire cke = ~valid_ro | ready_i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        valid_ro <= 0;
        pc_ro <= 32'd0;
        inst_ro <= 32'd0;
        r0data_ro <= 32'd0;
        r1data_ro <= 32'd0;
    end
    else begin
        if(cke) begin
            valid_ro <= valid_i & ~rsreserved_i; //matiawase
            pc_ro <= pc_i;
            inst_ro <= inst_i;
            r0data_ro <= r0data_i;
            r1data_ro <= r1data_i;
        end
    end
end

assign ready_o = cke & ~rsreserved_i; //matiawase
assign r0num_o = inst_i[`INST_RS1];
assign r0valid_o = (r_type | i_type | s_type | b_type) & valid_i;
assign r1num_o = inst_i[`INST_RS2];
assign r1valid_o = (r_type | s_type | b_type) & valid_i;
assign rdnum_o = inst_i[`INST_RD];
assign rdreserve_o = (r_type | i_type | u_type) & cke  & (valid_i & ~rsreserved_i); //matiawase

endmodule
`resetall
