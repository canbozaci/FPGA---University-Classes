`timescale 1ns / 1ps
module TOP(
    input clk,start,
    output done,
    output [19:0] result
    );
    wire done_conv;
    wire start_conv,shift_right;
    wire  [14:0] addr;
    wire  [7:0] din,dout;
    wire  [71:0] data_out;
control_FSM FSM(clk,start,done_conv,start_conv,done,shift_right,addr);
blk_mem_gen_0 blkmem(clk,1'b0,addr,din,dout);
conv_input_reg input_reg(clk,shift_right,dout,data_out);
CWODSP convolution(data_out[7:0],data_out[15:8],data_out[23:16],data_out[31:24],data_out[39:32],data_out[47:40],
data_out[55:48],data_out[63:56],data_out[71:64],8'd1,8'd2,8'd1,8'd2,8'd4,8'd2,8'd1,8'd2,8'd1,clk,1'b0,start_conv,result,done_conv);

endmodule