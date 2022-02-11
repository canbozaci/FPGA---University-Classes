`timescale 1ns / 1ps
module MSI_Library(
	
    );
endmodule

module DECODER(
	output reg [15:0] OUT,
	input [3:0] IN
	);
always@(*) 
	begin
		case(IN)
		4'b0000 : OUT = 1;
		4'b0001 : OUT = 2;
		4'b0010 : OUT = 4;
		4'b0011 : OUT = 8;
		4'b0100 : OUT = 16;
		4'b0101 : OUT = 32;
		4'b0110 : OUT = 64;
		4'b0111 : OUT = 128;
		4'b1000 : OUT = 256;
		4'b1001 : OUT = 512;
		4'b1010 : OUT = 1024;
		4'b1011 : OUT = 2048;
		4'b1100 : OUT = 4096;
		4'b1101 : OUT = 8192;
		4'b1110 : OUT = 16384;
		4'b1111 : OUT = 32768;
	endcase
	end
endmodule

// ENCODER with structural design
module ENCODER(
	output [1:0] OUT,
	input [3:0] IN,
	output E
	);
	wire temp;
	wire in_n;
	wire temp2;
	wire temp3;
OR	or0(OUT[1], IN[3],IN[2]);
NOT	not0(in_n,IN[2]);
	and(temp,in_n,IN[1]);
OR	or1(OUT[0],IN[3],temp);
OR	or2(temp2,IN[3],IN[2]);
OR 	or3(temp3,temp2,IN[1]);
OR  or4(E,temp3,IN[0]);
endmodule

// Encoder with always-case block design
module ENCODER2(
	output reg [1:0] OUT,
	input [3:0] IN,
	output reg E
	);
	always@(*) 
	begin
		case(IN)
		4'b0000 : begin
		OUT = 0;
		E = 0;
		end
		4'b0001 : begin
		OUT = 0;
		E = 1;
		end
		4'b0010 :begin
		OUT = 1;
		E = 1;
		end
		4'b0011 :begin
		OUT = 1;
		E = 1;
		end
		4'b0100 :begin
		OUT = 2;
		E = 1;
		end
		4'b0101 :begin
		OUT = 2;
		E = 1;
		end
		4'b0110 :begin
		OUT = 2;
		E = 1;
		end
		4'b0111 :begin
		OUT = 2;
		E = 1;
		end
		4'b1000 :begin
		OUT = 3;
		E = 1;
		end
		4'b1001 :begin
		OUT = 3;
		E = 1;
		end
		4'b1010 :begin
		OUT = 3;
		E = 1;
		end
		4'b1011 :begin
		OUT = 3;
		E = 1;
		end
		4'b1100 :begin
		OUT = 3;
		E = 1;
		end
		4'b1101 :begin
		OUT = 3;
		E = 1;
		end
		4'b1110 :begin
		OUT = 3;
		E = 1;
		end
		4'b1111 :begin
		OUT = 3;
		E = 1;
		end
		endcase
	end
	endmodule
	
// Multiplexer with structural design
module MUX(
	output O,
	input [3:0] D,
	input [1:0] S);
	assign O = (D[0]&(~S[0])&(~S[1]))|(D[1]&(S[0])&(~S[1]))|(D[2]&(~S[0])&(S[1]))|(D[3]&(S[0])&(S[1]));
	endmodule

// Multiplexer with always-case block design
module MUX2(
	output reg O,
	input [3:0] D,
	input [1:0] S);
	always@(*)
		begin
			case(S)
			2'b00 : O = D[0];
			2'b01 : O = D[1];
			2'b10 : O = D[2];
			2'b11 : O = D[3];
		endcase
		end
		endmodule

 // DEMUX
module DEMUX(
	output [3:0] O,
	input  D,
	input [1:0] S);
	wire so_n, s1_n, zz, zo, oz, oo;
	NOT not0(s0_n, S[0]);
	NOT not1(s1_n, S[1]);
	and(zz, s0_n, s1_n);
	and(zo, S[0], s1_n);
	and(oz, s0_n, S[1]);
	and(oo, S[0], S[1]);	
	TRI t0(O[0], D, zz);	
	TRI t1(O[1], D, zo);	
	TRI t2(O[2], D, oz);	
	TRI t3(O[3], D, oo);	

endmodule

	
	
	
