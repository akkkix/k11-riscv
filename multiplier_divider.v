function [63:0] multiplier(
    input [31:0] a,
    input a_signbit,
    input [31:0] b,
    input b_signbit
);

    wire [31:0] a1;
    wire [31:0] b1;
    wire [63:0] c;
    a1 = (a_signbit == 1'b1) ?  (~a + 1'b1) : a;
    b1 = (b_signbit == 1'b1) ?  (~b + 1'b1) : b;
    c = {32'd0,a} * {32'd0,b};
    multiplier = ((a_signbit ^ b_signbit) == 1'b1) ? (~c + 1'b1) : c;
endfunction

function [31:0] divider(
    input [31:0] a,
    input a_signbit,
    input [31:0] b,
    input b_signbit
);
begin
    wire [31:0] a1 = (a_signbit == 1'b1) ?  (~a + 1'b1) : a;
    wire [31:0] b1 = (b_signbit == 1'b1) ?  (~b + 1'b1) : b;
    wire [31:0] c = a / b;
    divider = 
        (b == 32'd0) ? 32'hFFFFFFFF :
        ((a_signbit ^ b_signbit) == 1'b1) ? (~c + 1'b1) :
        c;
end
endfunction

function [31:0] reminder(
    input [31:0] a,
    input a_signbit,
    input [31:0] b,
    input b_signbit
);
begin
    wire [31:0] a1 = (a_signbit == 1'b1) ?  (~a + 1'b1) : a;
    wire [31:0] b1 = (b_signbit == 1'b1) ?  (~b + 1'b1) : b;
    wire [31:0] c = a % b;
    divider = 
        (b == 32'd0) ? a :
        (a_signbit == 1'b1) ? (~c + 1'b1) :
        c;
end
endfunction