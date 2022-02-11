`timescale 1ns / 1ps
/*module tb(); //FOR BEHAV MULTIPLIER
reg clk,reset,start;
reg [7:0] A;
reg [7:0] B;
wire [15:0] result;
wire done;
MULTB uut(clk,reset,start,A,B,result,done);
always begin
	clk = 1;
	#5;
	clk = 0;
	#5;
end
initial begin;
	reset = 0;
	start = 1;
	A = 13;
	B = 5;
	#10;
	A = 21;
	B = 1;
	#10;
	B = 5;
	#10;
	start = 0;
	#10;
	start = 1;
	A = 70;
	B = 0;
	#10;
	A = 82;
	B = 4;
	#10;
	reset = 1;
	#10;
	start = 0;
	#10;
	start = 1;
	reset = 0;
	#10;
	$finish;	
end
endmodule*/

module tb(); // for structural multiplier
reg clk,reset,start;
reg [7:0] A;
reg [7:0] B;
wire [15:0] result;
wire done;
MULTS uut(clk,reset,start,A,B,result,done);
always begin
	clk = 1;
	#5;
	clk = 0;
	#5;
end
initial begin;
	reset = 0;
	start = 1;
	A = 13;
	B = 5;
	#10;
	start = 0;
	#20;
	start = 1;
	A = 21;
	B = 1;
	#10;
	start = 0;
	#20;
	start = 1;
	B = 5;
	#10;
	start = 0;
	#20;
	reset = 1;
	#10;
	reset = 0;
	#10;
	start = 1;
	#10;
	start = 0;
	#20;
	start =1;
	A = 255;
	B = 255;
	#10;
	start = 0;
	#30;
	$finish;	
end
endmodule

/*module tb();
	reg [7:0] f11,f12,f13,f21,f22,f23,f31,f32,f33,w11,w12,w13,w21,w22,w23,w31,w32,w33;
	reg clk,reset,start;
	wire [23:0] result;
	wire done;
CWODSP uut(f11,f12,f13,f21,f22,f23,f31,f32,f33,w11,w12,w13,w21,w22,w23,w31,w32,w33,clk,reset,start,result,done);
always begin
	clk = 1;
	#5;
	clk = 0;
	#5;
end
initial begin
	reset = 0;
	start = 1;
	w11=1;
	w12=2;
	w13=1;
	w21=2;
	w22=4;
	w23=2;
	w31=1;
	w32=2;
	w33=1;
	f11=1;
	f12=2;
	f13=3;
	f21=4;
	f22=5;
	f23=6;
	f31=7;
	f32=8;
	f33=9;
	#50;
	$finish;
end
endmodule*/