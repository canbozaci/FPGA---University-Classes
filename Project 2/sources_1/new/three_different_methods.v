`timescale 1ns / 1ps
module three_different_methods( );
endmodule
module with_SSI(
	input a,b,c,d,
	output f3,f2,f1,f0
);
//  GATE LEVEL DESIGN
	wire temp1,temp2,temp3,temp4,temp5,temp6;
	
	and(temp1,a,d);
	and(temp2,b,c);
	and(f3,temp1,temp2);
	
	and(temp3,a,c);
	NAND nand0(temp4,b,d);
	and(f2,temp3,temp4);
	
	EXOR exor0(f1,temp1,temp2);

	and(f0,b,d);
	
endmodule

module with_decoder(
	input a,b,c,d,
	output f3,f2,f1,f0
);
// With DECODER
	wire [15:0] y;
	DECODER decoder0(y,{a,b,c,d});

	wire temp7,temp8,temp9,temp10,temp11;
		
	OR or0(temp7,y[5],y[15]);
	OR or1(temp8,y[13],y[7]);
	OR or2(f0,temp7,temp8);
	
	OR or3(temp9,y[6],y[9]);
	OR or4(temp10,y[11],y[14]);
	OR or5(temp11,temp8,temp9);
	OR or6(f1,temp11,temp10);
	
	OR or7(f2,temp10,y[10]);
	
assign f3 = y[15];
endmodule




module with_MUX(
	input a,b,c,d,
	output f3,f2,f1,f0
);
// With MUX
	wire temp12,temp13,temp14,temp15,temp16,temp17,temp18;
	
	and(temp12,b,d);
	MUX mux0(f0,{temp12,temp12,temp12,temp12},{a,c});
	
	NOT	not0(temp13,d);
	NOT	not1(temp14,b);
	and(temp15,b,temp13);
	and(temp16,d,temp14);
	OR or0(temp17,temp16,temp15);
	MUX mux1(f1,{temp17,d,b,1'b0},{a,c});
	
	NAND nand0(temp18,b,d);
	MUX mux2(f2,{temp18,1'b0,1'b0,1'b0},{a,c});
	
	MUX mux3(f3,{temp12,1'b0,1'b0,1'b0},{a,c});
	
endmodule
	
