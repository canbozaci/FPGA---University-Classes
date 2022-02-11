`timescale 1ns / 1ps
// MEALY
module tb();
reg x,clk;
wire z;
FSM1 uut(x,clk,z);
//FSM2 uut(x,clk,z);
reg [41:0] input_data = 42'b010111000111000011110000011111000000111111;
reg [41:0] view_data  = 42'b010011000111000011110000011111000000111111;
integer i;
initial begin
	for (i = 0; i<43; i=i+1) begin
	x = input_data[41];
	input_data = input_data << 1;
	#10;
	end
	$finish;
	end
always begin
	clk = 0;
	#5;
	clk = 1;
	#5;
	end
endmodule



// MOORE
/*module tb();
reg x,clk;
wire z;
//FSM1 uut(x,clk,z);
FSM2 uut(x,clk,z);
reg [41:0] input_data = 42'b010111000111000011110000011111000000111111;
reg [41:0] view_data  = 42'b010011000111000011110000011111000000111111;

initial begin
	x = 0;
	#15;
	end
always begin
	clk = 0;
	#5;
	clk = 1;
	#5;
	end
always@(posedge clk) begin
	input_data = input_data << 1;
	x = input_data[41];
if(input_data == 0) begin
	#20;
	$finish;
	end
end
endmodule*/

//// FSM 3////////////
/*module tb(); 
reg x,clk;
reg rst;
wire z;
FSM3 uut(x,clk,rst,z);
reg [15:0] input_data  = 16'b1011000010110111;
reg [15:0] input_data2 = 16'b1000010010010011;
reg data1_out_valid,data2_out_valid;
integer i =0;
initial begin
	x = 0;
	rst =0;
	data1_out_valid = 1;
	data2_out_valid = 0;
	end
always begin
	clk = 0;
	#5;
	clk = 1;
	#5;
	end
always@(posedge clk) begin
	input_data = input_data << 1;
	x = input_data[15];
	if(input_data == 0) begin
		if(i==0) begin 
			data1_out_valid = 0;
			#20;
			data2_out_valid = 1;
			rst = 1;
			i = 1;
			#10;
		end
		if(i) begin
			rst = 0;
			input_data2 = input_data2 << 1;
			x = input_data2[15];
		end
		if(input_data2 == 0) begin
			data2_out_valid = 0;
			#10;
			$finish;
		end
	end
end
endmodule*/

//// FSM 3////////////
/*module tb(); 
reg x,clk;
reg rst;
wire z;
FSM3 uut(x,clk,rst,z);
reg [15:0] input_data  = 16'b1011000010110111;
reg [15:0] input_data2 = 16'b1000010010010011;
reg data1_out_valid,data2_out_valid;
integer i =0;
integer k;
initial begin
	x = 0;
	rst =0;
	data1_out_valid = 1;
	data2_out_valid = 0;
	#15;
for(k=0;k<40;k=k+1) begin
	input_data = input_data << 1;
	x = input_data[15];
	if(input_data == 0) begin
		if(i==0) begin 
			data1_out_valid = 0;
			#20;
			data2_out_valid = 1;
			rst = 1;
			i = 1;
			#10;
		end
		if(i) begin
			rst = 0;
			input_data2 = input_data2 << 1;
			x = input_data2[15];
		end
		if(input_data2 == 0) begin
			data2_out_valid = 0;
			#10;
			$finish;
		end
	end
	#10;
end
end
always begin
	clk = 0;
	#5;
	clk = 1;
	#5;
	end
endmodule*/