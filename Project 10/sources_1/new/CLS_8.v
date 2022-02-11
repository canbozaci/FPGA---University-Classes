`timescale 1ns / 1ps
module CLS_8(
	input [7:0] a,
	output [7:0]r
    );
	
assign r = {a[6:0],a[7]};
endmodule
