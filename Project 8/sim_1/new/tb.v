`timescale 1ns / 1ps
module tb(); 
reg [10:0] x;
wire [7:0] y;
wire [6:0] x_dec;
wire [20:0] x_frac;
wire [4:0] y_dec;
wire [20:0] y_frac;
arccosh UUT(x,y);
assign x_dec = x[10:5];
assign x_frac = x[4:0]*3125;
assign y_dec = y[7:4];
assign y_frac = y[3:0]*625;
reg [10:0] input_x[1:992]; 
integer i,k;
integer fin,fd,fdd;
initial
	begin
		fin= $fopen("input_verilog.mem","r");
		for(i=1;i<993;i=i+1) begin
            $fscanf(fin,"%b\n",input_x[i]); 
		end
		$fclose(fin);
		fd = $fopen("output_verilog_decimal.txt", "w");
		fdd = $fopen("output_verilog_binary.txt", "w");
		for(k=1;k<993;k=k+1) begin
			x = input_x[k];
			#20;
			
			// This part is to show output in decimal values.
			// It contains so much if else just to fix indexing, so i could compare to c output.
			if(y_frac == 0 & x_frac == 0) begin
			$fdisplay(fd, "For the value x = %0d.0000%0d ==> y= %0d.000%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 625 & x_frac == 0) begin
			$fdisplay(fd, "For the value x = %0d.0000%0d ==> y= %0d.0%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 0 & x_frac == 3125) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.000%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 625 & x_frac == 3125) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.0%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 0 & x_frac == 6250) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.000%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 625 & x_frac == 6250) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.0%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 0 & x_frac == 9375) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.000%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 625 & x_frac == 9375) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.0%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(x_frac == 9375) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(x_frac == 6250) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(x_frac == 3125) begin
			$fdisplay(fd, "For the value x = %0d.0%0d ==> y= %0d.%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 625) begin
			$fdisplay(fd, "For the value x = %0d.%0d ==> y= %0d.0%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(y_frac == 0) begin
			$fdisplay(fd, "For the value x = %0d.%0d ==> y= %0d.000%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else if(x_frac == 0) begin
			$fdisplay(fd, "For the value x = %0d.0000%0d ==> y= %0d.%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			else begin
			$fdisplay(fd, "For the value x = %0d.%0d ==> y= %0d.%0d ",x_dec,x_frac,y_dec,y_frac);
			end
			// This Part shows the input and output in binary form
			$fdisplay(fdd,"For the value x = %b ==> y= %b ",x,y);
		end
		$fclose(fd);
		$fclose(fdd);

		$finish;
	end	
endmodule