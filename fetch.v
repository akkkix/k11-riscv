module fetch(
    input wire clk,
    input wire rst,
    
    // master port
    //output reg  [7:0] m_data,
    output reg        valid_ro,
    input  wire       ready_i,

    output reg [31:0] pc_ro,

    input wire [31:0] branch_addr_i,
    input wire branch_taken_i
);

wire cke = ~valid_ro | ready_i;
reg branch_taken_r;
reg branch_addr_r;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        valid_ro <= 1;
        pc_ro <= 0;
        branch_taken_r <= 0;
        branch_addr_r <= 0;
    end
    else begin
        if(cke) begin
            //valid_ro <= valid_i;
            pc_ro <= (branch_taken_r | branch_taken_i) ? branch_addr_i : pc_ro + 32'd4;
            branch_taken_r <= 1'b0;
        end
        else if(branch_taken_i) begin
            branch_taken_r <= branch_taken_i;
            branch_addr_r <= branch_addr_i;
        end
    end
end


endmodule