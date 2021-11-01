module id(
    input clk,
    input rst,

    // slave port
    //input  wire [7:0] s_data,
    input  wire       valid_i,
    output wire       ready_o,
    
    // master port
    //output reg  [7:0] m_data,
    output reg        valid_ro,
    input  wire       ready_i
);

wire cke = ~valid_ro | ready_i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
        valid_ro <= 0;
    end
    else begin
        if(cke) begin
            valid_ro <= valid_i;
        end
    end
end

endmodule