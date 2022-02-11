`timescale 1ns / 1ps
module decoder_4_to_16(
	input [3:0]RegAdd,
	input WE,
	output reg [15:0]Out
    );

always @(*) begin
	if(WE == 0)
		Out = 0;
	else begin
		case(RegAdd)
			4'b0000: Out = 1;
			4'b0001: Out = 2;
			4'b0010: Out = 4;
			4'b0011: Out = 8;
			4'b0100: Out = 16;
			4'b0101: Out = 32;
			4'b0110: Out = 64;
			4'b0111: Out = 128;
			4'b1000: Out = 256;
			4'b1001: Out = 512;
			4'b1010: Out = 1024;
			4'b1011: Out = 2048;
			4'b1100: Out = 4096;
			4'b1101: Out = 8192;
			4'b1110: Out = 16384;
			4'b1111: Out = 32768;
		endcase
	end
end

endmodule
