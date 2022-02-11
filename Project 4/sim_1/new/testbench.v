`timescale 1ns / 1ps
/*module testbench(); // simple memory element
reg a;
wire OUT;
Simple_Memory_Element UUT(a, OUT);
initial begin
	a = 0;
	#20;
	a = 1;
	#20;
	$finish;
end
endmodule*/

/*module testbench(); //SR LATCH WITH NOR
reg S, R;
wire Q, Qn;
SR_Latch_NOR UUT(S,R,Q,Qn);
initial begin
	{S,R} = 0;
	#20;	
	{S,R} = 1;
	#20;	
	{S,R} = 0;
	#20;	
	{S,R} = 2;
	#20;	
	{S,R} = 0;
	#20;	
	{S,R} = 1;
	#20;
	{S,R} = 3;
	#20;
	$finish;
end
endmodule*/

/*module testbench(); //SR LATCH WITH NAND
reg S, R;
wire Q, Qn;
SR_Latch_NAND UUT(S,R,Q,Qn);
initial begin
	{S,R} = 3;
	#20;	
	{S,R} = 2;
	#20;	
	{S,R} = 3;
	#20;	
	{S,R} = 1;
	#20;	
	{S,R} = 3;
	#20;	
	{S,R} = 2;
	#20;
	{S,R} = 0;
	#20;
	$finish;
end
endmodule*/

/*module testbench(); //D FF
reg D, clk;
wire Q, Qn;
D_FF UUT(D,clk,Qn,Q);
always begin
clk = 0;
#5;
clk = 1;
#5;
end
initial begin
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D= 0;
	#6;
	D = 0;
	#15;
	$finish;
end
endmodule*/

/*module testbench(); //MASTER SLAVE D FF
reg D, clk;
wire Q, Qn;
master_slave_D_FF UUT(D,clk,Qn,Q);
always begin
clk = 0;
#5;
clk = 1;
#5;
end
initial begin
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D= 0;
	#6;
	D = 0;
	#15;
	$finish;
end
endmodule*/

/*module testbench(); //D FF Behavioral Design
reg D, clk;
wire Q, Qn;
D_FF_behavioral_design UUT(D,clk,Qn,Q);
always begin
clk = 0;
#5;
clk = 1;
#5;
end
initial begin
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D = 0;
	#6;
	D = 1;
	#6;
	D= 0;
	#6;
	D = 0;
	#15;
	$finish;
end
endmodule*/

/*module testbench(); //8-bit-register
reg [7:0]in ;
reg clk,clear;
wire [7:0] out;
register_8_bit UUT(in,clk,clear,out);
integer i;
always begin
clk = 0;
#5;
clk = 1;
#5;
end
initial begin
	for (i=0;i<255;i=i+1) begin
		in = i;
		clear = 0;
		if(i == 10) begin
			clear = 1;
			#10;
		end
		if(i == 20) begin
			clear = 1;
			#10;
		end
		#10;
	end
	$finish;
end
endmodule*/

/*module testbench(); //block memory
reg clka, wea;
reg [3:0] addra;
wire [7:0] douta;
block_memory UUT(clka,wea,addra,douta);
integer i;
always begin
clka = 0;
#10;
clka = 1;
#10;
end

initial begin
	wea = 0;
	for(i=0;i<16;i=i+1) begin
		addra = i;
		#20;
	end
	#20;
	$finish;
end
endmodule*/


module testbench(); //FIFO
 reg  clk;
 reg  wr_en;
 reg  rd_en;
 reg  srst;
 reg  [7:0]  din;
 wire [7:0]  dout;
 wire [3:0]  data_count;
 wire  empty;
 wire  full;
 wire  overflow;
 wire  underflow;
integer i;
FIFO ffo0(clk,srst,din,wr_en,rd_en,dout,full,overflow,empty,underflow,data_count);
always begin
clk = 0;
#10;
clk = 1;
#10;
end

initial begin
	wr_en = 1;
	srst = 0;
	rd_en = 0;
	for(i = 0;i<16;i=i+1) begin
	din = i*8;
	#20;
	end
	rd_en = 1;
	wr_en = 0;
	#350;
	$finish;
end
endmodule