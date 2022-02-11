`timescale 1ns / 1ps
module MULT_4_to_1#(parameter N=8)(
	input [N-1:0] in0,in1,in2,in3,
	input [1:0] Sel,
	output reg [N-1:0] out
    );
	
always @(*) begin
	case(Sel)
		2'b00: out = in0;
		2'b01: out = in1;
		2'b10: out = in2;
		2'b11: out = in3;
	endcase
end
endmodule