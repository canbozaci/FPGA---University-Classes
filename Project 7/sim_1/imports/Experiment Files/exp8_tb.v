`timescale 1ns / 1ps
module exp8_tb();
	// -- Inputs and Outputs -- //
    reg clk;
    reg start;
	wire done;
    wire [19:0] result;
    reg k;
	// --- Unit Under Test --- //
    TOP 
    UUT(
        .clk(clk),
        .start(start),
		.done(done),
        .result(result)
    );
    // --- Clock generator --- //
    parameter CLK_PER=50;
	initial clk = 0; 
    always #(CLK_PER) clk = ~clk; 
	// ---------------------- //
    initial k = 1; // to write first value of result into out_file
	integer out_file;  // Output file handler ID
		
	initial begin
    $timeformat(-9, 2, " ns");
       start = 0; 
	   out_file= $fopen("output_image.txt","w");
       #10;
       start = 1;
       // We will wait for 128x128 convolution operations       
       repeat(16383)        // decreased the number from 16385 to 16383
            #(28*CLK_PER);  // Duration of one complete iteration, increased to 28 because i've added one more state

       #(28*CLK_PER);   // Wait for last result
       #(6*CLK_PER);
	   $fclose(out_file);
       $finish();	 
	end
	// ----- Write result to output file ----- //
	// This may be incompatible with your design. You may choose your own sampling strategy and code it seperately. 
	always @ (negedge UUT.FSM.done_conv)  // Sample output when done_conv signal is falling   
	begin
	   // This will prevent recording any uncalculated results at the beginning.
	   if(k == 1) begin
       #150; // for output to be stable at least 100 ns wait (first negedge is from dont care to 0)
       k = 0;
       end
	   else
	       $fdisplay(out_file,"%d",result);
	 end
	// --------------------------------------- //  
endmodule
