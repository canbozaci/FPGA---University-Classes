`timescale 1ns / 1ps

module SSI_Library(

    );

endmodule 
// ----------  ----------  ----------  ----------  	OR_GATE	   ----------  ----------  ----------  ---------- 
module OR(
	output O,
	input I1,
	input I2
    );
	assign O = I1 | I2;
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 

// ----------  ----------  ----------  ----------  	NOT_GATE   ----------  ----------  ----------  ---------- 
module NOT(
	output O,
	input I
    );
	assign O = ~I;
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 


// ----------  ----------  ----------  ----------  	NAND_GATE  ----------  ----------  ----------  ---------- 
module NAND(
	output reg O,
	input I1,
	input I2
    );
	always@(*)
	begin
	O=~(I1 & I2);
	end
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 

// ----------  ----------  ----------  ----------  	NOR_GATE   ----------  ----------  ----------  ---------- 
module NOR(
	output reg O,
	input I1,
	input I2
    );
	always@(*)
	begin
	O=~(I1 | I2);
	end
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 

// ----------  ----------  ----------  ----------  	EXOR_GATE  ----------  ----------  ----------  ---------- 
module EXOR(
	output O,
	input I1,
	input I2
    );
	LUT2#(.INIT(4'b0110))lut(.O(O),.I1(I1),.I0(I2));
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------

// ----------  ----------  ----------  ----------  	EXNOR_GATE ----------  ----------  ----------  ---------- 
module EXNOR(
	output O,
	input I1,
	input I2
    );
	LUT2#(.INIT(4'b1001))lut(.O(O),.I1(I1),.I0(I2));
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 

// ----------  ----------  ----------  ----------  TRI_GATE	   ----------  ----------  ----------  ---------- 
module TRI(
	output O,
	input I,
	input E
    );
	assign O = E ? I : 1'bz;
endmodule
// ----------  ----------  ----------  ----------  ----------  ----------  ----------  ----------  ---------- 
