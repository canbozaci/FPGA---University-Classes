`timescale 1ns / 1ps
module ADD_8(
	input [7:0] a,b,
	output [7:0] r,
	output cout
    );
	
assign {cout,r} = a + b;
endmodule
