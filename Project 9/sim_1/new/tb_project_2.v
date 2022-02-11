`timescale 1ns / 1ps
module tb_project_2();
reg clk,reset,x;
wire y;
project_2 uut(clk,reset,x,y);
reg[159:0] input_data = 'h2552D65554549585AB665C5A559510CD2263CABC;
wire [3:0] answer_from_data;
reg x_d1,x_d2,x_d3,x_d4;
reg r_d1,r_d2,r_d3,r_d4;
integer i;
integer k = 0;
assign answer_from_data = {x_d4,x_d3,x_d2,x_d1};
always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
end

initial begin
    $timeformat(-9, 2, " ns");
    x = 0;
    reset = 0;
    #15;
    for(i = 0;i<160;i=i+1) begin
        reset =0;      
        input_data = input_data << 1;
        x = input_data[159];
        if(i%21 == 0)
            reset = 1;
        #10;
    end
    $finish;
end
always begin
    if(k==0) begin
        #10;
        k    <= 1;
    end
    x_d1 <= x;    // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    x_d2 <= x_d1; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    x_d3 <= x_d2; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    x_d4 <= x_d3; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    r_d1 <= reset;// these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    r_d2 <= r_d1; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    r_d3 <= r_d2; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    r_d4 <= r_d3; // these are delayed signals and been done to implement algorithm and compare the results between this and the verilog code
    if((answer_from_data == 9 | answer_from_data == 5)) begin
        if (reset == 1 | r_d1 == 1 | r_d2 == 1 | r_d3 == 1 | r_d4 == 1)
            $display("in the time %0t :output must be 1 => but output is %b due to reset signal!",$time-5,y);
        else 
            $display("in the time %0t :output must be 1 => output is %b",$time-5,y);   
   end
   #10;
end
endmodule
