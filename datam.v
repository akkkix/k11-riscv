`include "./inst_def.v"
`default_nettype none
module datam(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  wire       valid_i,
    output wire       ready_o,
    
    // master port
    //    [7:0] m_data,
    output reg        valid_ro,
    input  wire       ready_i,

    input wire [31:0] pc_i,
    input wire [31:0] inst_i,
    input wire [31:0] r0data_i,
    input wire [31:0] r1data_i,
    input wire [31:0] result_i,

    output reg [31:0] pc_ro,
    output reg [31:0] inst_ro,
    output reg [31:0] r0data_ro,
    output reg [31:0] r1data_ro,
    output reg [31:0] result_ro,

    input wire [31:0] datamemdata_i
);

`include "./opcode_def.v"

wire [6:0] opcode = inst_i[`INST_OPCODE];
wire [2:0] funct3 = inst_i[`INST_FUNCT3];

wire cke = ~valid_ro | ready_i;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        valid_ro <= 0;
        pc_ro <= 0;
        inst_ro <= 0;
        r0data_ro <= 0;
        r1data_ro <= 0;
        result_ro <= 0;
    end
    else begin
        if(cke) begin
            valid_ro <= valid_i;
            pc_ro <= pc_i;
            inst_ro <= inst_i;
            r0data_ro <= r0data_i;
            r1data_ro <= r1data_i;
            if(opcode == BOP_LOAD) begin
                result_ro <= 
                    (funct3 == FUNCT3_LB) ? {{24{datamemdata_i[7]}},datamemdata_i[7:0]}:
                    (funct3 == FUNCT3_LH) ? {{16{datamemdata_i[15]}},datamemdata_i[15:0]}:
                    (funct3 == FUNCT3_LW) ? datamemdata_i:
                    (funct3 == FUNCT3_LBU) ? datamemdata_i:
                    (funct3 == FUNCT3_LHU) ? datamemdata_i}:
                    32'hFFFFFFFF;
            end else begin
                result_ro <= result_i;
            end
        end
    end
end

assign ready_o = cke;

endmodule
`resetall