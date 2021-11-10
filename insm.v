module insm(
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
    output reg [31:0] pc_ro,

    output wire [31:0] insmemaddr_o,
    input wire [31:0] insmemdata_i,

    output wire [31:0] inst_o,

    input wire jump_taken_i
);

wire cke = ~valid_ro | ready_i | jump_taken_i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        valid_ro <= 0;
        pc_ro <= 32'd0;
    end
    else begin
        if(cke) begin
            valid_ro <= valid_i & ~jump_taken_i;
            pc_ro <= pc_i;
        end
    end
end

assign ready_o = cke;
assign insmemaddr_o = pc_i;
assign inst_o = insmemdata_i;

endmodule