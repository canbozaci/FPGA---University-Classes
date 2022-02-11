`timescale 1ns / 1ps
module top(
    input clk,reset,start,
    input [7:0] InA,InB,
    output busy,
    output [7:0]Out //
    );

(*KEEP = "TRUE"*)
wire CO,Z,WE;
wire [7:0] CUconst;
wire [2:0] InMuxAdd;
wire [3:0] OutMuxAdd,RegAdd;
wire [1:0] InsSel;
wire [7:0] ALUinA,ALUinB,ALUout;

CU  cu_inst(clk,reset,start,CO,Z,CUconst,InMuxAdd,OutMuxAdd,RegAdd,WE,busy,InsSel);
RB  rb_inst(clk,reset,InA,InB,CUconst,InMuxAdd,OutMuxAdd,RegAdd,WE,ALUinA,ALUinB,ALUout,Out);
ALU alu_inst(InsSel,CO,Z,ALUinA,ALUinB,ALUout);
endmodule