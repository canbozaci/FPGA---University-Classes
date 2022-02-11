`timescale 1ns / 1ps

//		FOR DECODER PART 
module TOP(
	input [7:0] sw,
	input [3:0] btn,
	output [7:0] led,
	output [6:0] seg,
	output dp,
	output [3:0] an);

wire [15:0] OUT;
wire [3:0] IN;
assign led = OUT[7:0];
assign seg = OUT[14:8];
assign dp = OUT[15];
assign IN = sw[3:0];
assign an [3:0] = 4'b1110;

DECODER decoder1(OUT, IN);
endmodule

// FOR ENCODER PART
/*module TOP(
	input [7:0] sw,
	input [3:0] btn,
	output [7:0] led,
	output [6:0] seg,
	output dp,
	output [3:0] an);

wire [1:0] OUT;
wire [3:0] IN;
wire E;

assign led[1:0] = OUT;
assign led [7] = E;
assign IN = sw[3:0];

ENCODER encoder2(OUT, IN, E);
endmodule*/

//FOR MULTIPLEXER PART
/*module TOP(
	input [7:0] sw,
	input [3:0] btn,
	output [7:0] led,
	output [6:0] seg,
	output dp,
	output [3:0] an);

wire O;
wire [1:0] S;
wire [3:0] D;

assign led[0] = O;
assign S = btn [1:0];
assign D = sw[3:0];

MUX multiplexer(O, D, S);
endmodule*/

//FOR DEMULTIPLEXER PART
/*module TOP(
	input [7:0] sw,
	input [3:0] btn,
	output [7:0] led,
	output [6:0] seg,
	output dp,
	output [3:0] an);

wire [3:0] O;
wire [1:0] S;
wire D;

assign led[3:0] = O;
assign S = btn [1:0];
assign D = sw[0];

DEMUX demultiplexer(O, D, S);
endmodule*/


