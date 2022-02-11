`timescale 1ns / 1ps
module MULT_16_to_1 #(parameter N=8)(
	input [N-1:0]in0,
	input [N-1:0]in1,
	input [N-1:0]in2,
	input [N-1:0]in3,
	input [N-1:0]in4,
	input [N-1:0]in5,
	input [N-1:0]in6,
	input [N-1:0]in7,
	input [N-1:0]in8,
	input [N-1:0]in9,
	input [N-1:0]in10,
	input [N-1:0]in11,
	input [N-1:0]in12,
	input [N-1:0]in13,
	input [N-1:0]in14,
	input [N-1:0]in15,
	input [3:0]Sel,
	output reg [N-1:0]out
    );

always @(*) begin
	case(Sel)
		4'b0000: out = in0;
		4'b0001: out = in1;
		4'b0010: out = in2;
		4'b0011: out = in3;
		4'b0100: out = in4;
		4'b0101: out = in5;
		4'b0110: out = in6;
		4'b0111: out = in7;
		4'b1000: out = in8;
		4'b1001: out = in9;
		4'b1010: out = in10;
		4'b1011: out = in11;
		4'b1100: out = in12;
		4'b1101: out = in13;
		4'b1110: out = in14;
		4'b1111: out = in15;
	endcase
end
endmodule


