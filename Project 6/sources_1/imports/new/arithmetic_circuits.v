`timescale 1ns / 1ps
module arithmetic_circuits();
endmodule

module HA(
	(* dont_touch="true" *)input x,
	(* dont_touch="true" *)input y,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output s);
	
	assign cout = x & y;
	assign s = x ^ y;
endmodule

module FA(
	(* dont_touch="true" *)input x,
	(* dont_touch="true" *)input y,
	(* dont_touch="true" *)input ci,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output s);
	
	(* dont_touch="true" *) wire wr1;
	(* dont_touch="true" *) wire wr2;
	(* dont_touch="true" *) wire wr3;
HA ha0(x,y,wr1,wr2);
HA ha1(wr2,ci,wr3,s);
assign cout = wr1 | wr3;
endmodule

/*module RCA(
	(* dont_touch="true" *)input [3:0] x,
	(* dont_touch="true" *)input [3:0] y,
	(* dont_touch="true" *)input ci,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output [3:0] s
);
	(* dont_touch="true" *)wire wr4;
	(* dont_touch="true" *)wire wr5;
	(* dont_touch="true" *)wire wr6;
	FA fa0(x[0],y[0],ci,wr4,s[0]);
	FA fa1(x[1],y[1],wr4,wr5,s[1]);
	FA fa2(x[2],y[2],wr5,wr6,s[2]);
	FA fa3(x[3],y[3],wr6,cout,s[3]);
endmodule*/

module parametric_RCA
	#(parameter SIZE = 16)(
	(* dont_touch="true" *)input [SIZE-1:0] x,
	(* dont_touch="true" *)input [SIZE-1:0] y,
	(* dont_touch="true" *)input ci,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output [SIZE-1:0] s
);
	(* dont_touch="true" *)wire temp [SIZE:0];
	
	assign temp[0] = ci;
	
	genvar i;
	generate 
    for (i=0; i<SIZE; i=i+1) 
      begin
	 FA fa_param(x[i],y[i],temp[i],temp[i+1],s[i]);
	 end
	 endgenerate
	 assign cout = temp[SIZE];
endmodule

/*module CLA(
	(* dont_touch="true" *)input [3:0] x,
	(* dont_touch="true" *)input [3:0] y,
	(* dont_touch="true" *)input ci,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output [3:0] s);
(* dont_touch="true" *)wire g0,g1,g2,g3,p0,p1,p2,p3,c1,c2,c3,c4;

assign g0=(x[0]&y[0]);
assign g1=(x[1]&y[1]);
assign g2=(x[2]&y[2]);
assign g3=(x[3]&y[3]);
assign p0=(x[0]^y[0]);
assign p1=(x[1]^y[1]);
assign p2=(x[2]^y[2]);
assign p3=(x[3]^y[3]);

assign c0=ci;
assign c1=g0|(p0&ci);
assign c2=g1|(p1&g0)|(p1&p0&ci);
assign c3=g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&ci);
assign c4=g3|(p3&g2)|(p3&p2&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&ci);

assign s[0]=p0^c0;
assign s[1]=p1^c1;
assign s[2]=p2^c2;
assign s[3]=p3^c3;
assign cout=c4;
	
endmodule

module SRCA(
	(* dont_touch="true" *)input [3:0] x,
	(* dont_touch="true" *)input [3:0] y,
	(* dont_touch="true" *)input ci,
	(* dont_touch="true" *)output cout,
	(* dont_touch="true" *)output [3:0] s
);
	(* dont_touch="true" *)wire wr4;
	(* dont_touch="true" *)wire wr5;
	(* dont_touch="true" *)wire wr6;
	(* dont_touch="true" *)wire wr7;
	(* dont_touch="true" *)wire wr8;
	FA fa0(x[0],y[0],ci,wr4,s[0]);
	FA fa1(x[1],y[1],wr4,wr5,s[1]);
	FA fa2(x[2],y[2],wr5,wr6,s[2]);
	FA fa3(x[3],y[3],wr6,wr7,s[3]);
assign wr8 = (x[3])^(y[3]); // if the sign bits are not the same wr8 = 1, if same = 0
assign cout = wr8 ? s[3] : wr7; // if the sign bits are not same just give cout s[3], if same its wr7.
endmodule*/

	

