`timescale 1ns / 1ps
module RB(
    input clk,reset,
    input [7:0] InA,InB,CUconst,
    input [2:0] InMuxAdd,
    input [3:0] OutMuxAdd,RegAdd,
    input WE,
    output [7:0] ALUinA,ALUinB,
    input  [7:0] ALUout,
    output [7:0] Out
    );

(*KEEP = "TRUE"*)
wire [7:0]  RegOut,RegIn;
wire [15:0] DecoderOut;
wire [7:0]  Rout [15:0];

MULT_8_to_1 #(.N(8)) multiplexer_8_input(InA,InB,CUconst,ALUout,RegOut,RegOut,RegOut,RegOut,InMuxAdd,RegIn);
decoder_4_to_16 DECODER(RegAdd, WE,DecoderOut);
REGISTER #(.N(8)) REGISTERS0(clk,reset,DecoderOut[0],RegIn,Rout[0]);
REGISTER #(.N(8)) REGISTERS1(clk,reset,DecoderOut[1],RegIn,Rout[1]);
REGISTER #(.N(8)) REGISTERS2(clk,reset,DecoderOut[2],RegIn,Rout[2]);
REGISTER #(.N(8)) REGISTERS3(clk,reset,DecoderOut[3],RegIn,Rout[3]);
REGISTER #(.N(8)) REGISTERS4(clk,reset,DecoderOut[4],RegIn,Rout[4]);
REGISTER #(.N(8)) REGISTERS5(clk,reset,DecoderOut[5],RegIn,Rout[5]);
REGISTER #(.N(8)) REGISTERS6(clk,reset,DecoderOut[6],RegIn,Rout[6]);
REGISTER #(.N(8)) REGISTERS7(clk,reset,DecoderOut[7],RegIn,Rout[7]);
REGISTER #(.N(8)) REGISTERS8(clk,reset,DecoderOut[8],RegIn,Rout[8]);
REGISTER #(.N(8)) REGISTERS9(clk,reset,DecoderOut[9],RegIn,Rout[9]);
REGISTER #(.N(8)) REGISTERS10(clk,reset,DecoderOut[10],RegIn,Rout[10]);
REGISTER #(.N(8)) REGISTERS11(clk,reset,DecoderOut[11],RegIn,Rout[11]);
REGISTER #(.N(8)) REGISTERS12(clk,reset,DecoderOut[12],RegIn,Rout[12]);
REGISTER #(.N(8)) REGISTERS13(clk,reset,DecoderOut[13],RegIn,Rout[13]);
REGISTER #(.N(8)) REGISTERS14(clk,reset,DecoderOut[14],RegIn,Rout[14]);
REGISTER #(.N(8)) REGISTERS15(clk,reset,DecoderOut[15],RegIn,Rout[15]);
MULT_16_to_1 #(.N(8)) multiplexer_16_output(Rout[0],Rout[1],Rout[2],Rout[3],Rout[4],Rout[5],Rout[6],
Rout[7],Rout[8],Rout[9],Rout[10],Rout[11],Rout[12],Rout[13],Rout[14],Rout[15],OutMuxAdd,RegOut);

assign Out = Rout[0];
assign ALUinA = Rout[1];
assign ALUinB = Rout[2];
endmodule
