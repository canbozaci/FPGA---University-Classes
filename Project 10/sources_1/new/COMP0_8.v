`timescale 1ns / 1ps
module COMP0_8(
	input [7:0]a,
	output reg z
    );
	
always @(*) begin
	if(a==0)
	 	z=1;
	else 
		z=0;
end
endmodule
