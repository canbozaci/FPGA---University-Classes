`timescale 1ns / 1ps
module MULT_8_to_1 #(parameter N=8)(
	input [N-1:0]in0,
	input [N-1:0]in1,
	input [N-1:0]in2,
	input [N-1:0]in3,
	input [N-1:0]in4,
	input [N-1:0]in5,
	input [N-1:0]in6,
	input [N-1:0]in7,
	input [2:0]Sel,
	output reg [N-1:0]out
    );
	
always @(*) begin
	case(Sel)
		3'b000: out = in0;
		3'b001: out = in1;
		3'b010: out = in2;
		3'b011: out = in3;
		3'b100: out = in4;
		3'b101: out = in5;
		3'b110: out = in6;
		3'b111: out = in7;
	endcase
end
endmodule


