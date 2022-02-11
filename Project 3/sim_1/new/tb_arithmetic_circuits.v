`timescale 1ns / 1ps
module tb_arithmetic_circuits(); // Signed RCA
reg [3:0]x;
reg [3:0]y;
reg ci;
wire cout;
wire [3:0]s;
wire signed [4:0]carry_with_sum;
assign carry_with_sum = {cout,s};
SRCA UUT(x,y,ci,cout,s);
integer i,j;

initial
	begin
		ci = 0;
		for (i=-8;i<8;i=i+1) begin
			x = i;
			for(j=-8;j<8;j=j+1) begin
			y = j;
			#20;
			end
			
		end
		$finish;
	end
endmodule

/*module tb_arithmetic_circuits(); // UNTILL RCA ADDER + CLA
reg [3:0]x;
reg [3:0]y;
reg ci;
wire cout;
wire [3:0]s;
RCA UUT(x,y,ci,cout,s);
integer i;
initial
	begin
		for(i =0; i<512;i = i + 1) begin
		{x,y,ci} = i;
		#20;
		end
		$finish;
	end
endmodule*/


/*module tb_arithmetic_circuits();          // - FOR PARAM RCA
 parameter SIZE = 8;
reg [SIZE-1:0] x;
reg [SIZE-1:0] y;
reg cin;
wire cout;
wire [SIZE-1:0] s;
parametric_RCA UUT(x,y,cin,cout,s);
integer i;
initial
	begin
		x = 199;
		y = 121;
		cin = 1;
		#20
		x=255;
		y=255;
		cin=1;
		#20
		x=1;
		y=0;
		cin=0;
		#20
		x=53;
		y=45;
		cin=0;
		#20
		x=127;
		y=127;
		#20;
		$finish;
	end
endmodule
*/

/*module tb_arithmetic_circuits(); -- UNTILL RCA ADDER
reg [3:0]x;
reg [3:0]y;
reg ci;
wire cout;
wire [3:0]s;
RCA UUT(x,y,ci,cout,s);
integer i;
initial
	begin
		for(i =0; i<512;i = i + 1) begin
		{x,y,ci} = i;
		#20;
		end
		$finish;
	end
endmodule*/
