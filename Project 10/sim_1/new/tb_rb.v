`timescale 1ns / 1ps
module tb_rb();
reg clk,reset,WE;
reg [7:0] InA,InB,CUconst,ALUout;
reg [2:0] InMuxAdd;
reg [3:0] OutMuxAdd,RegAdd;
wire [7:0] ALUinA,ALUinB;
wire [7:0] Out; 
RB uut(clk,reset,InA,InB,CUconst,InMuxAdd,OutMuxAdd,RegAdd,WE,ALUinA,ALUinB,ALUout,Out);
initial begin
    clk = 0;
    #20;
    reset = 1;
    #50;
    reset = 0;
    InA = 5;
    InB = 10;
    CUconst = 5;
    ALUout = 10;
    InMuxAdd = 0;
    OutMuxAdd = 0;
    RegAdd = 0;
    WE = 0;
    #10;
    WE = 1;
    #10;
    OutMuxAdd=0;
    #10;
    OutMuxAdd = 1;
    #20;
    RegAdd = 1;
    InA = 15;
    #10;
    OutMuxAdd = 2;
    #20;
    RegAdd = 2;
    #20;
$finish;
end
always #10 clk = ~clk;
endmodule
