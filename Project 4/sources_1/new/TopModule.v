`timescale 1ns / 1ps
module TopModule();
endmodule

module Simple_Memory_Element(
		(* dont_touch="true" *) input IN,
		(* dont_touch="true" *)	output OUT2
		);	
	(* dont_touch="true" *)	wire a;
	(* dont_touch="true" *)	wire b;
	assign a = IN;
	NOT not0(a,b);
	NOT not1(b,a);
	assign OUT2 = b;
endmodule

module SR_Latch_NOR(
		input S,
		input R,
		output Q,
		output Qn
		);	
NOR nor0(Q,R,Qn);		
NOR nor1(Qn,S,Q);		
endmodule

module SR_Latch_NAND(
		input S,
		input R,
		output Q,
		output Qn
		);	
NAND nand0(Qn,R,Q);		
NAND nand1(Q,S,Qn);		
endmodule
	
module D_FF(
		input D,
		input clk,
		output Qn,
		output Q);
		wire temp1,temp2,temp3;
NAND nand0(temp1,D,clk);
NOT not0(temp3,D);
NAND nand1(temp2,temp3,clk);
NAND nand2(Q,temp1,Qn);
NAND nand3(Qn,temp2,Q);
endmodule

module master_slave_D_FF(
		input D,
		input clk,
		output Qn,
		output Q);
		wire temp1,temp2;
D_FF dl0(D,clk,temp1,temp2);
NOT not0(temp3,clk);
D_FF dl1(temp2,temp3,Qn,Q);
endmodule

module D_FF_behavioral_design(
		input D,
		input clk,
		output reg Qn,
		output reg Q);
		reg FF;
	always@(posedge clk) begin
		FF = D;
		Q = FF;
		Qn = ~FF;		
	end
endmodule

module register_8_bit(
		input [7:0] in,
		input clk,
		input clear,
		output reg [7:0] out
		);
	always@(posedge clk or posedge clear) begin
		if(clear == 1)
		out = 0;
		else
		out = in;		
	end
endmodule


module block_memory(
	input clka,
	input wea,
	input [3:0] addra,
	output [7:0] douta
    );
	wire [7:0] din;
blk_mem_gen_0 bl0(clka,wea,addra,din,douta);
endmodule

module FIFO(
 input   clk,
 input   srst,
 input  [7:0]  din,
 input   wr_en,
 input   rd_en,
 output [7:0]  dout,
 output  full,
 output  overflow,
 output  empty,
 output  underflow,
 output [3:0]  data_count
    );
fifo_generator_0  fifo0(clk,srst,din,wr_en,rd_en,dout,full,overflow,empty,underflow,data_count);
endmodule