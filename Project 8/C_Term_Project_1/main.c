#include <stdio.h> 
#include <conio.h>
#include <stdint.h>
#include <math.h>
int main(){
    double x = 1,y = 0,x_max = 31.96875; // x input, y output
    int loop_max;
    int x_16,x_8,x_4,x_2,x_1,x_f2,x_f4,x_f8,x_f16,x_f32,y_4,y_2,y_1,y_f2,y_f4,y_f8,y_f16; // decimal and fraction parts of x and y
    double q = 16, w=8, e=4, r=2, t=1, l = 0.5, m=0.25, o=0.125,p=0.0625, b = 0.03125;// to make code more visable
    loop_max = ((x_max-x)/b)+1; // step size is 0.03125 = b, x_max = 31.96875
    for(int i=0;i<loop_max;++i){ // x limits [0,32) with steps of 1/32, is totally 992 steps.
        y = acosh(x); // arccosh(x) function from math library
        y = y - fmod(y,p); // to make output compatible with our step size 1/32
        if(y >= 4){
            y = 3.9375; // if output is greater than our limits it is reduced to max value of the limits
        }
        // FROM DECIMAL TO THE 11 POINT FIXED - 6 BIT DECIMAL - 5 BIT FRACTION - FOR X VALUE - Step Value is 1/32
        x_16  = floor(x/(q));
        x_8   = floor(fmod(x,q)/w);
        x_4   = floor(fmod(x,w)/e);
        x_2   = floor(fmod(x,e)/r);
        x_1   = floor(fmod(x,r)/t);
        x_f2  = floor(fmod(x,t)/(l));
        x_f4  = floor(fmod(x,l)/(m));
        x_f8  = floor(fmod(x,m)/(o));
        x_f16 = floor(fmod(x,o)/(p));
        x_f32 = floor(fmod(x,p)/(b));
         // FROM DECIMAL TO THE 8 POINT FIXED - 4 BIT DECIMAL - 4 BIT FRACTION - FOR Y VALUE - Step value is 1/16
        y_4   = floor(y/e);
        y_2   = floor(fmod(y,e)/r);
        y_1   = floor(fmod(y,r)/t);
        y_f2  = floor(fmod(y,t)/(l));
        y_f4  = floor(fmod(y,l)/(m));
        y_f8  = floor(fmod(y,m)/(o));
        y_f16 = floor(fmod(y,o)/(p));
// TO COMPARE WITH VERILOG OUTPUT.TXT  // use "./main > output_c_decimal.txt" command to see the output result of printf into txt
           //printf("For the value x = %.5f ==> y= %.4f \n",x,y);
// TO COMPARE WITH VERILOG OUTPUT.TXT  // use "./main > output_c_binary.txt" command to see the output result of printf into txt
          //printf("For the value x = 0%d%d%d%d%d%d%d%d%d%d ==> y = 0%d%d%d%d%d%d%d\n",x_16,x_8,x_4,x_2,x_1,x_f2,x_f4,x_f8,x_f16,x_f32,y_4,y_2,y_1,y_f2,y_f4,y_f8,y_f16);
//PRINTING THE OUTPUT VALUES FOR CASE STATEMENT IN VERILOG // use "./main > output_to_verilog_code.txt" command to see the output result of printf into txt
           /*if (i == 0){
             printf("`timescale 1ns / 1ps\n module arccosh(\n \tinput [10:0] x,\n \toutput reg [7:0] y\n );\n always@(*) begin\n case(x)\n");
             }
             printf("11'b0%d%d%d%d%d%d%d%d%d%d : y=8'b0%d%d%d%d%d%d%d %c\n",x_16,x_8,x_4,x_2,x_1,x_f2,x_f4,x_f8,x_f16,x_f32,y_4,y_2,y_1,y_f2,y_f4,y_f8,y_f16,59);
             if (i==991){
             printf("	default : y = 8'b11111111;\n endcase\n end\n endmodule");
             }   */    
// PRINTING THE INPUT BITS OF X FOR TESTBENCH OF VERILOG // use "./main > input_verilog.mem" command to see the output result of printf
       //printf("0%d%d%d%d%d%d%d%d%d%d\n",x_16,x_8,x_4,x_2,x_1,x_f2,x_f4,x_f8,x_f16,x_f32);
        if(i!=991) { // THIS WAS DONE FOR DEBUGING PURPOSES, to not increase x.
            x = x + 0.03125; // increment value of x, 1/32 (the least significant fraction bit value of x)
            }
   }    
}