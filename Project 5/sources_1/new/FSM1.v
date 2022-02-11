`timescale 1ns / 1ps
///////////////////////////////////FSM 1 MEALY//////////////////////////////////////
module FSM1(
	input x,
	input clk,
	output z
    );	
	wire q_t2,q_t1,q_t0;
	reg Q2,Q1,Q0;
	
initial begin
	Q2 <= 1;
	Q1 <= 1;
	Q0 <= 0;	
end

assign q_t2 = (x&Q2)|(x&Q1&Q0);
assign q_t1 = (Q1&(~Q0)) | ((~Q2)&(~Q1)&Q0) | (x&(~Q2)&(~Q1));
assign q_t0 = (x&(~Q1)) | ((~Q2)&(~Q1)&(~Q0)) | (x&(~Q0));
assign z = (x&Q2&Q0) | ((~x)&Q1&(~Q0));

always@(posedge clk) begin
	Q2 <= q_t2;
	Q1 <= q_t1;
	Q0 <= q_t0;
end
endmodule

///////////////////////////////////FSM 1 MOORE//////////////////////////////////////
/*module FSM1(
	input x,
	input clk,
	output reg z
    );	
	wire q_t2,q_t1,q_t0,z_t;
	reg Q2,Q1,Q0;
	
initial begin
	Q2 <= 0;
	Q1 <= 0;
	Q0 <= 0;	
end

assign q_t2 = (x&Q2)|(x&Q1&Q0);
assign q_t1 = (Q1&(~Q0)) | ((~Q2)&(~Q1)&Q0) | (x&(~Q2)&(~Q1));
assign q_t0 = (x&(~Q1)) | ((~Q2)&(~Q1)&(~Q0)) | (x&(~Q0));
assign z_t = (x&Q2&Q0) | ((~x)&Q1&(~Q0));


always@(posedge clk) begin
	Q2 <= q_t2;
	Q1 <= q_t1;
	Q0 <= q_t0;
	z  <= z_t;
end
endmodule*/



///////////////////////////////////FSM 2 MEALY///////////////////////////////////////////

module FSM2(
	input x,
	input clk,
	output z
    );
    (* dont_touch="true" *)	wire q_t2,q_t1,q_t0,a_t;
	(* dont_touch="true" *)reg Q2,Q1,Q0,a;
initial begin
	Q2 <= 0;
	Q1 <= 0;
	Q0 <= 0;
	a <= 0;
end

assign a_t = ~(x^Q2);
assign q_t2 = x;
assign q_t1 = (a_t&Q0)|(a_t&Q1);
assign q_t0 = a_t&(~Q1)&(~Q0);
assign z = a_t&Q1;


always@(posedge clk) begin
	Q2 <= q_t2;
	Q1 <= q_t1;
	Q0 <= q_t0;
	a  <= a_t;
end
endmodule

///////////////////////////////////FSM 2 MOORE///////////////////////////////////////////

/*module FSM2(
	input x,
	input clk,
	output reg z
    );
	(* dont_touch="true" *)	wire q_t2,q_t1,q_t0,a_t,z_t;
	(* dont_touch="true" *)reg Q2,Q1,Q0,a;
initial begin
	Q2 <= 0;
	Q1 <= 0;
	Q0 <= 0;
	a <= 0;
end

assign a_t = ~(x^Q2);
assign q_t2 = x;
assign q_t1 = (a_t&Q0)|(a_t&Q1);
assign q_t0 = a_t&(~Q1)&(~Q0);
assign z_t = a_t&Q1;


always@(posedge clk) begin
	Q2 <= q_t2;
	Q1 <= q_t1;
	Q0 <= q_t0;
	a  <= a_t;
	z  <= z_t;
end
endmodule*/

////////////////////////////////////////////////////////////////////////////////////

module FSM3(
	input x,
	input clk,rst,
	output z
    );
reg[3:0] state;
parameter A = 4'b0000,    
		  B = 4'b0100,    
		  C = 4'b0101,    
		  D = 4'b1100,    
		  E = 4'b0001,    
		  F = 4'b1111,    
		  G = 4'b0111,    
		  H = 4'b1011,    
		  I = 4'b1101,    
		  J = 4'b1001;    
						  
always@(posedge clk or posedge rst) begin
	if(rst ==1) 
		state <= A;
	else begin
		case (state)
		A: if(x)
				state <= B;
			else 
				state <= A;
		B: if(x)
				state <= B;
			else
				state <= C;
		C: if(x) 
				state <= D;
			else 
				state <= E;
		D: if(x) 
				state <= F;
			else
				state <= C;
		E: if(x) 
				state <= G;
			else 
				state <= A;
		F: if(x)
				state <= B;
			else 
				state <= H;
		G: if(x) 
				state <= B;
			else
				state <= I;
		H: if(x)
				state <= J;
			else
				state <= E;
		I: if(x)
				state <= D;
			else 
				state <= J;
		J: if(x) 
				state <= J;
			else 
				state <= J;
		default: state <= A;
		endcase
	end
end
assign z = state ==J;
endmodule

