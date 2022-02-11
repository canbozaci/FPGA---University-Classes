`timescale 1ns / 1ps
module convolution_circuits(
	
    );
endmodule

// Behavioral Multiplication
module MULTB(
	input clk,reset,start,
	input [7:0] A,B,
	output reg [15:0] result,
    output reg done
	);
	always@(posedge clk) begin
		if(reset || ~start) begin
			done   <= 0;
			result <= 0;
		end
		else if(start) begin
			result <= A * B;
			done   <= 1;
		end
	end			
endmodule


module CWODSP
	(
	input [7:0] f11,f12,f13,f21,f22,f23,f31,f32,f33,w11,w12,w13,w21,w22,w23,w31,w32,w33,
	input clk,reset,start,
	output [23:0] result,
	output done
	);
	wire [15:0] m1,m2,m3,m4,m5,m6,m7,m8,m9;
	wire done1,done2,done3,done4,done5,done6,done7,done8,done9;
	wire [23:0] sum1,sum2,sum3,sum4,sum5,sum6,sum7;
	wire cout1,cout2,cout3,cout4,cout5,cout6,cout7,cout8;
MULTB mult1(clk,reset,start,f11,w11,m1,done1);
MULTB mult2(clk,reset,start,f12,w12,m2,done2);
MULTB mult3(clk,reset,start,f13,w13,m3,done3);
MULTB mult4(clk,reset,start,f21,w21,m4,done4);
MULTB mult5(clk,reset,start,f22,w22,m5,done5);
MULTB mult6(clk,reset,start,f23,w23,m6,done6);
MULTB mult7(clk,reset,start,f31,w31,m7,done7);
MULTB mult8(clk,reset,start,f32,w32,m8,done8);
MULTB mult9(clk,reset,start,f33,w33,m9,done9);

parametric_RCA #(24) rca0({8'b00000000,m1},{8'b00000000,m2},1'b0,cout1,sum1);		
parametric_RCA #(24) rca1({8'b00000000,m3},{8'b00000000,m4},1'b0,cout2,sum2);		
parametric_RCA #(24) rca2({8'b00000000,m5},{8'b00000000,m6},1'b0,cout3,sum3);		
parametric_RCA #(24) rca3({8'b00000000,m7},{8'b00000000,m8},1'b0,cout4,sum4);
		
parametric_RCA #(24) rca4(sum1,{8'b00000000,m9},1'b0,cout5,sum5);		
parametric_RCA #(24) rca5(sum2,sum3,1'b0,cout6,sum6);
		
parametric_RCA #(24) rca6(sum4,sum5,1'b0,cout7,sum7);

parametric_RCA #(24) rca7(sum6,sum7,1'b0,cout8,result);
assign done = done1 & done2 & done3 & done4 & done5 & done6 & done7 & done8 & done9;		
endmodule