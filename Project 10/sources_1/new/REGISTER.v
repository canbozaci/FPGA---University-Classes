`timescale 1ns / 1ps
module REGISTER #(parameter N=8)(
	input clk,
	input reset,
	input en,
	input [N-1:0] in,
	output reg [N-1:0] out
    );

(*KEEP = "TRUE"*)
reg [N-1:0]reg_next; // assigned to reg_out every posedge clk, if not reset || if enable 1 assigned by in else by reg_out (previous)
reg [N-1:0]reg_out;  // assigned to out every time

always @(posedge clk, posedge reset) begin
	if(reset)
		reg_out <= 0;
	else
		reg_out <= reg_next;
end

always @(*) begin
	if(en) begin
		reg_next = in;
    end
	else begin
		reg_next = reg_out;
    end
    out = reg_out;
end


endmodule
