`timescale 1ns / 1ps
module ALU(
    input [1:0] InsSel,
    output CO,Z,
    input [7:0] ALUinA,ALUinB,
    output [7:0] ALUout
    );
    
wire [7:0] r_and,r_xor,r_add,r_cls;
wire cout;

AND_8 AND_8_BIT(ALUinA,ALUinB,r_and); 
XOR_8 XOR_8_BIT(ALUinA,ALUinB,r_xor);   
ADD_8 ADD_8_BIT(ALUinA,ALUinB,r_add,cout);
CLS_8 CLS_8_BIT(ALUinA,r_cls);
MULT_4_to_1 #(.N(8)) MULT4_OUT(r_and,r_xor,r_add,r_cls,InsSel,ALUout);
MULT_4_to_1 #(.N(1)) MULT4_CARRY(1'b0,1'b0,cout,r_cls[0],InsSel,CO);
COMP0_8 ZERO_COMPARATOR_8_BIT(ALUout,Z);
endmodule
