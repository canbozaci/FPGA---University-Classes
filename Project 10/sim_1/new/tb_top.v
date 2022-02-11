`timescale 1ns / 1ps
module tb_top();
// Inputs
reg clk;
reg reset;
reg [7:0] InA;
reg [7:0] InB;
reg start;
// Outputs
wire [7:0] Out;
wire busy;
// registers and integers to be used in the testbench for both verification and viewing output results in tcl console
reg [7:0] A = 8'd255;
reg [7:0] B = 8'd255;
reg [7:0] C = 8'd254;

integer counter = 0;
integer counter_uplimit = 35; // number of trials that will be done!
// Instantiate top as uut
top uut(clk,reset,start,InA,InB,busy,Out);
always #5 clk = ~clk; // creating 10ns period clock (100MHzp)
initial begin
	// Initialize Inputs
	clk 	= 0;
	reset   = 0;
	InA     = 0;
	InB     = 0;
	start   = 0;
	#10;
	reset   = 1;
	#10;
	reset   = 0;
	#10;
	start 	= 1;
	InA 	= A; 
	InB 	= B;
    #20;
	start 	= 0;
	#100;
end
always begin
	if(counter == counter_uplimit) begin
		$display ("\n\t\t\t\t\t\t\t\tSimulation has succesfully completed with %0d trials\n",counter);
		$finish;
	end
    if(uut.cu_inst.state_reg == 6'd2)
        InA = C;
	if(uut.cu_inst.state_reg == 6'd63) begin
		if(Out != ((A+B+C)/3)) begin
			$display("For the values \t A = %-3d \t  B = %-3d \t C = %-3d \t (A+B+C)/3 found in hardware = %-3d \t Whereas it must be = %-3d", A, B, C, Out, ((A+B+C)/3));
			$display("Error Occured when on this calculation of mean when counter was %0d", counter);
			$finish;
		end
		start = 0;
		counter 	  = counter + 1;
		#20;
		$display("For the values \t A = %-3d \t  B = %-3d \t C = %-3d \t (A+B+C)/3 found in hardware = %-3d \t Whereas it must be = %-3d", A, B, C, Out, ((A+B+C)/3));
		InA = $random%256;
		InB = $random%256;
		C 	= $random%256;
		#10;
		A 	  = InA;
		B 	  = InB;
		reset = 1;
		#10;
		reset = 0;
		start = 1;
		#10;
		start = 0;
	end
	#10;	
end   
endmodule

