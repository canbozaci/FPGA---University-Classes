`timescale 1ns / 1ps
module tb_alu();
reg [7:0] ALUinA,ALUinB;
reg [1:0] InsSel;
wire [7:0] ALUout;
wire CO,z;
ALU uut_ALU(InsSel,CO,Z,ALUinA,ALUinB,ALUout);
initial begin
		ALUinA = 0;
		ALUinB = 0;
		InsSel = 0;
		#10;
		ALUinA = 8'b10100101;
		ALUinB = 8'b10000111;
		#20;
		InsSel = 2'b01;
		ALUinA = 8'b10110101;
		ALUinB = 8'b10101001;
		#20;
		ALUinA = 8'b01101111;
		ALUinB = 8'b11111111;
		#20;
		InsSel = 2'b10;
		ALUinA = 8'b01101001;
		ALUinB = 8'b10110001;
		#20;
		InsSel = 2'b11;
		ALUinA = 8'b01101001;
		#20;
        ALUinA = 8'b11101001;
		#20;
		$finish;	
end
endmodule
