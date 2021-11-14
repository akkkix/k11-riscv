function [31:0] arithmetic_right_shifter(
    input [31:0] data,
    input [4:0] shamt
);
case (shamt)
    5'd0: arithmetic_right_shifter = data;
    5'd1: arithmetic_right_shifter = {{1{data[31]}},data[31:1]} ;
    5'd2: arithmetic_right_shifter = {{2{data[31]}},data[31:2]} ;
    5'd3: arithmetic_right_shifter = {{3{data[31]}},data[31:3]} ;
    5'd4: arithmetic_right_shifter = {{4{data[31]}},data[31:4]} ;
    5'd5: arithmetic_right_shifter = {{5{data[31]}},data[31:5]} ;
    5'd6: arithmetic_right_shifter = {{6{data[31]}},data[31:6]} ;
    5'd7: arithmetic_right_shifter = {{7{data[31]}},data[31:7]} ;
    5'd8: arithmetic_right_shifter = {{8{data[31]}},data[31:8]} ;
    5'd9: arithmetic_right_shifter = {{9{data[31]}},data[31:9]} ;
    5'd10: arithmetic_right_shifter = {{10{data[31]}},data[31:10]} ;
    5'd11: arithmetic_right_shifter = {{11{data[31]}},data[31:11]} ;
    5'd12: arithmetic_right_shifter = {{12{data[31]}},data[31:12]} ;
    5'd13: arithmetic_right_shifter = {{13{data[31]}},data[31:13]} ;
    5'd14: arithmetic_right_shifter = {{14{data[31]}},data[31:14]} ;
    5'd15: arithmetic_right_shifter = {{15{data[31]}},data[31:15]} ;
    5'd16: arithmetic_right_shifter = {{16{data[31]}},data[31:16]} ;
    5'd17: arithmetic_right_shifter = {{17{data[31]}},data[31:17]} ;
    5'd18: arithmetic_right_shifter = {{18{data[31]}},data[31:18]} ;
    5'd19: arithmetic_right_shifter = {{19{data[31]}},data[31:19]} ;
    5'd20: arithmetic_right_shifter = {{20{data[31]}},data[31:20]} ;
    5'd21: arithmetic_right_shifter = {{21{data[31]}},data[31:21]} ;
    5'd22: arithmetic_right_shifter = {{22{data[31]}},data[31:22]} ;
    5'd23: arithmetic_right_shifter = {{23{data[31]}},data[31:23]} ;
    5'd24: arithmetic_right_shifter = {{24{data[31]}},data[31:24]} ;
    5'd25: arithmetic_right_shifter = {{25{data[31]}},data[31:25]} ;
    5'd26: arithmetic_right_shifter = {{26{data[31]}},data[31:26]} ;
    5'd27: arithmetic_right_shifter = {{27{data[31]}},data[31:27]} ;
    5'd28: arithmetic_right_shifter = {{28{data[31]}},data[31:28]} ;
    5'd29: arithmetic_right_shifter = {{29{data[31]}},data[31:29]} ;
    5'd30: arithmetic_right_shifter = {{30{data[31]}},data[31:30]} ;
    5'd31: arithmetic_right_shifter = {{31{data[31]}},data[31:31]} ;
    default: arithmetic_right_shifter = 32'hffffffff;
endcase
    
endfunction