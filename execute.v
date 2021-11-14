`include "./inst_def.v"
`default_nettype none

module execute(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  wire       valid_i,
    output wire       ready_o,
    
    // master port
    //output reg  [7:0] m_data,
    output reg        valid_ro,
    input  wire       ready_i,

    input wire [31:0] pc_i,
    input wire [31:0] inst_i,
    input wire [31:0] r0data_i,
    input wire [31:0] r1data_i,

    output reg [31:0] pc_ro,
    output reg [31:0] inst_ro,
    output reg [31:0] r0data_ro,
    output reg [31:0] r1data_ro,
    output reg [31:0] result_ro,
    
    output wire [31:0] jumpaddr_o,
    output wire jumptaken_o,

    output wire [31:0] datamemaddr_o, 
    output wire [31:0] datamemdata_o,
    output wire datamemwrite_o,
    output wire [1:0] datamemwidth_o

);

`include "./opcode_def.v"

wire [6:0] opcode = inst_i[`INST_OPCODE];
wire [11:0] inst_imm_20 = inst_i[`I_INST_IMM_20];
wire [11:0] inst_imm_25_7 = {inst_i[`S_INST_IMM_25],inst_i[`S_INST_IMM_7]};
wire [19:0] inst_imm_31_12_20_21 = {inst_i[`J_INST_IMM_31],inst_i[`J_INST_IMM_12],inst_i[`J_INST_IMM_20],inst_i[`J_INST_IMM_21]};
wire [11:0] inst_imm_31_7_25_8 =  {inst_i[`B_INST_IMM_31],inst_i[`B_INST_IMM_7],inst_i[`B_INST_IMM_25],inst_i[`B_INST_IMM_8]};
wire [2:0] funct3 = inst_i[`INST_FUNCT3];
wire [6:0] funct7 = inst_i[`INST_FUNCT7];


// branch signed comp
wire [31:0] r0subr1 = r0data_i + (~r1data_i) + 32'd1;
wire r0subr1_of = (r0data_i[31] & (~r1data_i[31]) & ~r0subr1[31]) | ((~r0data_i[31]) & (r1data_i[31]) & r0subr1[31]); // (-) + (-) -> (+) or (+) + (+) -> (-)
wire r0subr1_zero = ((r0subr1 == 32'd0) ? 1'b1 : 1'b0);
//
wire branch_taken = 
    (funct3 == FUNCT3_BEQ) ? ((r0data_i == r1data_i) ? 1'b1 : 1'b0) :
    (funct3 == FUNCT3_BNE) ? ((r0data_i != r1data_i) ? 1'b1 : 1'b0) :
    (funct3 == FUNCT3_BLTU) ? ((r0data_i < r1data_i) ? 1'b1 : 1'b0) :
    (funct3 == FUNCT3_BGEU) ? ((r0data_i >= r1data_i) ? 1'b1 : 1'b0) :
    (funct3 == FUNCT3_BLT) ? (r0subr1[31] ^ r0subr1_of) & ~r0subr1_zero :
    (funct3 == FUNCT3_BGE) ? (r0subr1[31] ~^ r0subr1_of) | r0subr1_zero :
    1'b0;

wire cke = ~valid_ro | ready_i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        valid_ro <= 0;
        pc_ro <= 32'd0;
        inst_ro <= 32'd0;
        r0data_ro <= 32'd0;
        r1data_ro <= 32'd0;
        result_ro <= 32'd0;

    end
    else begin
        if(cke) begin
            valid_ro <= valid_i;
            pc_ro <= pc_i;
            inst_ro <= inst_i;
            r0data_ro <= r0data_i;
            r1data_ro <= r1data_i;
            if(opcode == BOP_OPIMM) begin
                result_ro <=
                    (funct3 == FUNCT3_ADD) ? r0data_i + {{20{inst_imm_20[11]}} ,inst_imm_20} : 
                    (funct3 == FUNCT3_XOR) ? r0data_i ^ {{20{inst_imm_20[11]}} ,inst_imm_20} :
                    (funct3 == FUNCT3_OR) ? r0data_i | {{20{inst_imm_20[11]}} ,inst_imm_20} :
                    (funct3 == FUNCT3_AND) ? r0data_i & {{20{inst_imm_20[11]}} ,inst_imm_20} :
                    (funct3 == FUNCT3_SLL) ? r0data_i << inst_imm_20[4:0] :
                    (funct3 == FUNCT3_SRL && funct7 == FUNCT7_SRL) ? r0data_i >> inst_imm_20[4:0] :
                    32'hFFFFFFFF;
            end else if(opcode == BOP_OP) begin
                result_ro <= 
                    (funct3 == FUNCT3_ADD && funct7 == FUNCT7_ADD) ? r0data_i + r1data_i :
                    (funct3 == FUNCT3_SUB && funct7 == FUNCT7_SUB) ? r0data_i + (~r1data_i) + 32'd1 :
                    (funct3 == FUNCT3_XOR) ? r0data_i ^ r1data_i :
                    (funct3 == FUNCT3_OR) ? r0data_i | r1data_i :
                    (funct3 == FUNCT3_AND) ? r0data_i & r1data_i :
                    (funct3 == FUNCT3_SLL) ? r0data_i << r1data_i[4:0] :
                    (funct3 == FUNCT3_SRL && funct7 == FUNCT7_SRL) ? r0data_i >> r1data_i[4:0] :
                    32'hFFFFFFFF;
            end else if(opcode == BOP_LUI) begin
                result_ro <= {inst_i[`U_INST_IMM_12] , {12{1'b0}}};
            end else if(opcode == BOP_AUIPC) begin
                result_ro <= {inst_i[`U_INST_IMM_12] , {12{1'b0}}} + pc_i;
            end else if(opcode == BOP_JAL) begin
                result_ro <= pc_i + 32'd4; 
            end else if(opcode == BOP_JALR) begin
                result_ro <= pc_i + 32'd4; 
            end else begin 
                result_ro <= 32'hFFFFFFFF;
            end
        end
    end
end

assign ready_o = cke;

assign jumpaddr_o = 
    (opcode == BOP_JAL) ? pc_i + {{11{inst_imm_31_12_20_21[19]}} ,inst_imm_31_12_20_21, 1'b0} :
    (opcode == BOP_JALR) ? ((r0data_i + {{20{inst_imm_20[11]}} ,inst_imm_20}) & 32'hFFFFFFFE) :
    (opcode == BOP_BRANCH) ? pc_i + {{19{inst_imm_31_7_25_8[11]}}, inst_imm_31_7_25_8, 1'b0} :
    32'hFFFFFFFF;
assign jumptaken_o =
    (
        (opcode == BOP_JAL) ? 1'b1 :
        (opcode == BOP_JALR) ? 1'b1 :
        (opcode == BOP_BRANCH) ? branch_taken :
        1'b0
    ) & cke & valid_i;

assign datamemaddr_o = 
    (opcode == BOP_LOAD) ? r0data_i + {{20{inst_imm_20[11]}},inst_imm_20} :
    (opcode == BOP_STORE) ? r0data_i + {{20{inst_imm_25_7[11]}},inst_imm_25_7} :
    32'h00000000;
assign datamemdata_o = r1data_i;
assign datamemwrite_o = ((opcode == BOP_STORE) ? 1'b1 : 1'b0) & cke & valid_i;
assign datamemwidth_o = funct3[1:0];

endmodule
`resetall
