`default_nettype none

module dataram(clk,addr,write,din,dout);
    parameter WORD = 32;
    parameter ADDR = 32;
    parameter LEN = 65535;

    input clk;
    input [ADDR -1:0] addr;
    input write;
    input [WORD-1:0] din;
    output [WORD-1:0] dout;

    reg [WORD-1:0] mem_bank [0:LEN];
    reg [WORD-1:0] o_r;

    assign dout = o_r;

    always @(posedge clk) begin
        if (write) begin
            mem_bank[addr] <= din;
        end else begin
            o_r <= mem_bank[addr];
        end
    end

    // initial begin
    //     $readmemh("./mem/dataram.dat",mem_bank);
    // end
endmodule
