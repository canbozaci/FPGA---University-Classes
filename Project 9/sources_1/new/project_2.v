`timescale 1ns / 1ps
module project_2(
    input clk,reset,x,
    output reg y
    );
reg[3:0] state;
wire y_t;
parameter S0 = 0,// 4'b0000,
          S1 = 1,// 4'b0001,
          S2 = 2,// 4'b0011,
          S3 = 3,// 4'b0010,
          S4 = 4,// 4'b0110,
          S5 = 5,// 4'b0111,
          S6 = 6,// 4'b0101,
          S7 = 7,// 4'b0100,
          S8 = 8;// 4'b0101;

always@(posedge clk) begin
    if(reset == 1) begin
        state <= S0;
        y     <= 0;
    end
    else begin
        y = y_t;
        case (state)
        S0: if(x)
            state <= S2;
        else 
            state <= S1;
        S1: if(x)
            state <= S3;
        else 
            state <= S1;
        S2: if(x)
            state <= S2;
        else 
            state <= S6;
        S3: if(x)
            state <= S2;
        else 
            state <= S4;
        S4: if(x)
            state <= S5;
        else 
            state <= S7;
        S5: if(x)
            state <= S2;
        else 
            state <= S4;
        S6: if(x)
            state <= S3;
        else 
            state <= S7;
        S7: if(x)
            state <= S8;
        else 
            state <= S1;
        S8: if(x)
            state <= S2;
        else 
            state <= S4;
        default: state <= S0;
        endcase;
    end
end
assign y_t = (state == S8 | state == S5);
endmodule
