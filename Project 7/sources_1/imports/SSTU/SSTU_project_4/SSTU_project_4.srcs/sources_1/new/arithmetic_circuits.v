`timescale 1ns / 1ps


module arithmetic_circuits(

    );
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

module RCA(
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
endmodule

module parametric_RCA
	#(parameter SIZE = 8)(
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




