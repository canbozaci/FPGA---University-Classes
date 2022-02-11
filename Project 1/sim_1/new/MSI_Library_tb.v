`timescale 1ns / 1ps

module MSI_Library_tb();
		
	  reg [7:0] sw;
      reg [3:0] btn;
      wire [7:0] led;
      wire [6:0] seg;
      wire dp;
      wire [3:0] an;
	TOP UUT(sw, btn, led, seg, dp, an);
	integer i,k;
	initial
	
		begin
			for(i =0; i<16;i = i + 1) begin
			sw = i;
			for(k=0;k<4;k=k+1) begin
			btn=k;
			#20;
			end
			#20;
			end
			$finish;
		end	
endmodule
