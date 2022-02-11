`timescale 1ns / 1ps
module control_FSM(
	input clk,start,done_conv,
	output reg start_conv,done,shift_right,
	output reg [14:0] addr
 );
reg [3:0] state;
reg [6:0] i;
reg [6:0] j;
reg [14:0] readen_address;
parameter IDLE 	 = 4'b0000,
		  RP1  	 = 4'b0001,
		  RP2  	 = 4'b0010,
		  RP3  	 = 4'b0011,
		  RP4  	 = 4'b0100,
		  RP5  	 = 4'b0101,
		  RP6  	 = 4'b0110,
		  RP7  	 = 4'b0111,
		  RP8  	 = 4'b1000,
		  RP9  	 = 4'b1001,
		  CONV 	 = 4'b1010,
		  INCR_J = 4'b1011,
		  temp   = 4'b1111; // created because it doesnt shift in the last rp9 so the result is more wrong, it just waits 1 clock cycle from rp9 to conv state

always@(posedge clk) begin
readen_address <= (i+1)*128 + j + 3 + (i*2);
	case (state)
	IDLE: begin
		shift_right <= 0;
		start_conv	<= 0;
		if(start) begin
			done 	<= 0;
			i 		<= 0;
			j 		<= 0;
			state 	<= RP1;
		end
		else
			state 	<= IDLE;
	end	
	RP1: begin
		addr 		<= i*128 + j + 0 + (i*2);
		shift_right <= 1;
		state 		<= RP2;
	end
	RP2: begin
		addr 		<= i *128 + j + 1 + (i*2) ;
		shift_right <= 1;
		state 		<= RP3;
	end
	RP3: begin
		addr 		<= i*128 + j +2+ (i*2);
		shift_right <= 1;
		state 		<= RP4;
	end
	RP4: begin
		addr 		<=(i+1)*128 + j +2+ (i*2);
		shift_right <= 1;
		state 		<= RP5;
	end
	RP5: begin
		addr 		<= (i+1)*128 + j + 3 + (i*2);
		shift_right <= 1;
		state 		<= RP6;
	end
	RP6: begin
		addr 		<= (i+1)*128 + j+4+ (i*2);
		shift_right <= 1;
		state 		<= RP7;
	end
	RP7: begin
		addr 		<= (i+2)*128 + j+4+ (i*2);
		shift_right <= 1;
		state 		<= RP8;
	end
	RP8: begin
		addr 		<= (i+2)*128 + j+5+ (i*2);
		shift_right <= 1;
		state 		<= RP9;
	end
	RP9: begin
		addr        <= (i+2)*128 + j+6+ (i*2);
		shift_right <= 1;
		state       <= temp;
	end
	temp: begin
		state  <= CONV;
	end
	CONV: begin
		shift_right <= 0;
		start_conv  <= 1;
		if(done_conv)
			state 	<= INCR_J;
		else
			state 	<= CONV;
	end
	INCR_J: begin
		shift_right <= 0;
		start_conv  <= 0;
		if(j==127) begin
			if(i==127) begin
				done  <= 1;
				state <= IDLE;
			end
			else begin
				j 	  <= 0;
				i 	  <= i + 1;
				state <= RP1;
			end
		end
		else begin
			j     	<= j + 1;
			state 	<= RP1;
		end
	end
	default : state <= IDLE;	
	endcase
end		
endmodule

	

