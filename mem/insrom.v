`default_nettype none

module insrom(clk,rst,cke,addr,dout);
    parameter WORD = 32;
    parameter ADDR = 32;
    parameter LEN = 65535;

    input clk;
    input rst;
    input cke;
    input [ADDR -1:0] addr;
    output [WORD-1:0] dout;

    reg [7:0] mem_bank [0:LEN];
    reg [WORD-1:0] o_r;

    assign dout = o_r;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            o_r <= 32'd0;
        end else begin
            if(cke) begin
                o_r <= {mem_bank[addr+3],mem_bank[addr+2],mem_bank[addr+1],mem_bank[addr]};
            end
        end

    end

    initial begin
        $readmemh("./mem/insrom.dat",mem_bank);
    end
endmodule
