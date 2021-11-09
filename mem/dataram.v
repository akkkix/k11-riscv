`default_nettype none

module dataram(clk,addr,width,write,din,dout);
    parameter WORD = 32;
    parameter ADDR = 32;
    parameter LEN = 65535;

    input clk;
    input [ADDR -1:0] addr;
    input [1:0] width;
    input write;
    input [WORD-1:0] din;
    output [WORD-1:0] dout;

    reg [7:0] mem_bank [0:LEN];
    reg [WORD-1:0] o_r;

    assign dout = o_r;

    always @(posedge clk) begin
        if (write) begin
            if(width == 2'b00) begin
                mem_bank[addr] <= din[7:0];
            end else if(width == 2'b01) begin
                mem_bank[addr] <= din[7:0];
                mem_bank[addr+1] <= din[15:8];
            end else if(width == 2'b10) begin
                mem_bank[addr] <= din[7:0];
                mem_bank[addr+1] <= din[15:8];
                mem_bank[addr+2] <= din[23:16];
                mem_bank[addr+3] <= din[32:24];
            end
            
        end else begin
            if(width == 2'b00) begin
                o_r <= {24'd0,mem_bank[addr]};
            end else if(width == 2'b01) begin
                o_r <= {16'd0,mem_bank[addr+1],mem_bank[addr]};
            end else if(width == 2'b10) begin
                o_r <= {mem_bank[addr+3],mem_bank[addr+2],mem_bank[addr+1],mem_bank[addr]};
            end
        end
    end

    // initial begin
    //     $readmemh("./mem/dataram.dat",mem_bank);
    // end
endmodule
