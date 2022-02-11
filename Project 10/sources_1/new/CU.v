`timescale 1ns / 1ps
module CU(
    input clk,reset,start,CO,Z,
    output reg [7:0] CUconst,
    output reg [2:0] InMuxAdd,
    output reg [3:0] OutMuxAdd,RegAdd,
    output reg WE,busy,
    output reg [1:0] InsSel   
    );
    (*KEEP = "TRUE"*)
    parameter   // total of 48 states (because moore type of machine there is more states then mealy type
        // if we designed that we would have less states)done so i need state_reg of [5:0]
    s_idle 	                = 6'd0,
    s_getA                  = 6'd1,
    s_getB                  = 6'd2,
    s_waitC                 = 6'd3,
    s_getC                  = 6'd4,
    s_firstSum              = 6'd5,
    s_CReg2                 = 6'd6,
    s_secondSum             = 6'd7,
    s_storem3const           = 6'd8,
    s_CReg2_C1              = 6'd9,
    s_secondSum_C1          = 6'd10,
    s_write_CO1             = 6'd11,
    s_write_CO2             = 6'd12,
    s_write_CO0             = 6'd13,
    s_startdiv              = 6'd14,
    s_loadResult            = 6'd15,
    s_loadResult_C1         = 6'd16,
    s_increment             = 6'd17,
    s_const1                = 6'd18,
    s_storedivresult        = 6'd19,
    s_storeincrement        = 6'd20,
    s_b0finish              = 6'd21,
    s_b1finish              = 6'd22,
    s_b2finish              = 6'd23,
    s_store1const           = 6'd24,
    s_storemodreg5          = 6'd25,
    s_store3const2          = 6'd26,
    s_lookcarries           = 6'd27,
    s_andoperation          = 6'd28,
    s_store2const           = 6'd29,
    s_andoperation2         = 6'd30,
    s_onecarryp             = 6'd31,
    s_twocarryp             = 6'd32,
    s_onecarrymod           = 6'd33,
    s_sumwithcarry1         = 6'd34,
    s_store3const3          = 6'd35,
    s_twocarrymod           = 6'd36,
    s_sumwithcarry2         = 6'd37,
    s_mod0                  = 6'd38,
    s_resultintoreg10       = 6'd39,
    s_storemodreg5_Z        = 6'd40,
    s_storemodreg5_NZ       = 6'd41,
    s_SET85                 = 6'd42,
    s_SET86                 = 6'd43,
    s_SET170                = 6'd44,
    s_SET171                = 6'd45,
    s_finish                = 6'd62,  
    s_finished              = 6'd63; // this one is assigned to last value because i was testing according to this value in the testbench 

	(*KEEP = "TRUE"*)   
	reg [5:0]next_state, state_reg;
    
    always @(posedge clk, posedge reset)
    begin
        if(reset==1)
        state_reg <= s_idle;
        else
        state_reg <= next_state;
      end

    always @(*)
    begin
        case(state_reg)
            s_idle: // the idle state when the circuit gets started
            begin
                busy           <= 1'b0;
                CUconst        <= 8'dz;
                WE             <= 1'dz;
                OutMuxAdd      <= 4'dz;
                RegAdd         <= 4'dz;
                InMuxAdd       <= 3'dz;
                InsSel         <= 2'dz;
                next_state     <= s_idle;
                if(start)
                    next_state <= s_getA;
            end

            s_getA: //write InA into register1
            begin
                busy        <= 1'b1;
                InMuxAdd    <= 3'd0;
                RegAdd      <= 4'd1;
                WE          <= 1'b1;
                next_state  <= s_getB;
            end

            s_getB: // write InB into register2
            begin
                WE         <= 1'b1;
                InMuxAdd   <= 3'd1;
                RegAdd     <= 4'd2;
                next_state <= s_waitC;
            end

            s_waitC: // 1 clock cycle wait for C input and give it into the InA ( 2clk cycle after start give the C input to the Ina)
            begin
                WE         <= 1'b0;
                next_state <= s_getC;
            end

            s_getC: // write InC into register3 //
            begin
                InMuxAdd   <= 3'd0;
                RegAdd     <= 4'd3;
                WE         <= 1'b1;
                next_state <= s_firstSum;
            end
            
            s_firstSum:  // do the A+B operation and store it into Reg1, if carry produced there is different branching
            begin
                WE          <= 1'b0;
                InsSel      <= 2'd2;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd1;
                next_state  <= s_loadResult;
                if(CO) begin
                    next_state <= s_loadResult_C1;
                end         
            end

            s_loadResult: // load the result produced from A+B into register1 (no carry branch)
            begin  
                WE         <= 1'b1;
                next_state <= s_CReg2;
            end

            s_loadResult_C1: // load the result produced from A+B into register1 (one carry branch)
            begin  
                WE         <= 1'b1;
                next_state <= s_CReg2_C1;
            end


            s_CReg2_C1: // get the C data into reg2 (one carry branch)
            begin
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                OutMuxAdd   <= 4'd3;
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd2;
                next_state  <= s_secondSum_C1;
            end

            s_CReg2: // get the C data into reg2 (no carry branch)
            begin
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                OutMuxAdd   <= 4'd3;
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd2;
                next_state  <= s_secondSum;
            end

            s_secondSum_C1: // (one carry branch)  do the (A+B) + C operation  store it into REG9 if there is a carry then go into 
                // two carry branch if not there is only one carry so go into one carry branch
            begin
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd9;
                next_state  <= s_write_CO1;//one carry branch i'll write into a register so ican later know that there was one carry produced
                if(CO)
                    next_state <= s_write_CO2;//two carry branch i'll write into a register so ican later know that there was two carry produced
            end

            s_secondSum: //(0 carry branch) do the (A+B) + C operation  store it into REG9 if there is a carry then go into 
                // one carry branch if not there is no carry so go into no carry branch
            begin
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd9;
                next_state  <= s_write_CO0; //zero carry branch i'll write into a register so ican later know that there was one carry produced
                if(CO)
                    next_state <= s_write_CO1; //one carry branch i'll write into a register so ican later know that there was one carry produced
            end

            s_write_CO0: // no carry produced, reg15 has the value stored 0 
            begin
                RegAdd      <= 4'd15;
                WE          <= 1'b1;  
                CUconst     <= 8'd0;
                InMuxAdd    <= 3'd2;
                next_state  <= s_storem3const;
                if(Z)
                    next_state <= s_mod0; // if the whole multiplication had produced zero (carry's not included)
            end

            s_write_CO1: // one carry produced, reg15 has the value stored 1 
            begin
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd15;
                WE          <= 1'b1;
                CUconst     <= 8'd1;
                next_state  <= s_storem3const;
                if(Z)
                    next_state <= s_mod0; // if the whole multiplication had produced zero (carry's not included)
            end

            s_write_CO2: // two carry produced, reg15 has the value stored 2 
            begin
                RegAdd       <= 4'd15;
                WE           <= 1'b1;
                CUconst      <= 8'd2;
                InMuxAdd     <= 3'd2;
                next_state   <= s_storem3const;
                if(Z)
                    next_state <= s_mod0; // if the whole multiplication had produced zero (carry's not included)
            end

            s_storem3const: // minus three (in 2's complement) stored into register2 second operand of ALU
            // i will constantly subtract three from the (A+B+C) (not included carries)
            begin
                CUconst     <= 8'b11111101;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                next_state  <= s_startdiv;
            end
            
            s_startdiv: // start division by 3 by adding -3 to the (A+B+C)
            begin
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                OutMuxAdd   <= 4'd9; 
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd1;        
                next_state  <= s_storedivresult;
            end

            s_storedivresult: //store the subtracted data into reg9
            begin
                WE          <= 1'b1;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd9;
                InsSel      <= 2'd2;
                next_state  <= s_increment; // go into incrementing result value which starts from zero becasue default value of reg's are 
                // set to be zero in my design
                if(Z)
                    next_state <= s_b0finish; // if zero is produced then go into s_b0finish to add 1 to the result (also the mod3 is zero)
                else if (!CO)
                    next_state <= s_store1const; // because i am working with two's complement I know that there will always be a carry 
                    // unless the result is less then 3 or equal to 3.
            end

            s_increment: // register10 (increment register) into register1 to add 1
            begin
                InsSel      <= 2'd2;
                WE          <= 1'b1;
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd1;
                OutMuxAdd   <= 4'd10;
                next_state  <= s_const1;
            end

            s_const1: // constant 1 into register2, as well as adding them together
            begin
                RegAdd      <= 4'd2;
                WE          <= 1'b1;
                InsSel      <= 2'd2;
                CUconst     <= 8'd1;
                InMuxAdd    <= 3'd2;
                next_state  <= s_storeincrement;
            end

            s_storeincrement: // store the increment into register10 again
            begin
                WE          <= 1'b1;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd10;
                next_state  <= s_storem3const;
            end
          
            s_b0finish: // Get the value of increment into Reg1 
            begin
                InsSel      <= 2'd2;
                WE          <= 1'b1;
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd1;
                OutMuxAdd   <= 4'd10;
                next_state  <= s_b1finish;
            end

            s_b1finish: // constant 1 into register2, while adding 1 to the increment
            begin
                WE          <= 1'b1;
                CUconst     <= 8'd1;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                next_state  <= s_b2finish;
            end

            s_b2finish: // store the increment into register10 again 
            begin
                WE          <= 1'b1;
                InMuxAdd    <= 3'd3;
                RegAdd      <= 4'd10;
                next_state  <= s_mod0; // because the result was 3 which means (A+B+C) mod3 = 0
            end

            s_mod0: // we write 0 into the reg5 which is holding the (A+B+C) (mod3) value
            begin
                CUconst     <= 8'd0;
                WE          <= 1'b1;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd5;
                next_state  <= s_store3const2;
            end
            
            s_store1const: // when the (A+B+C) % mod3 != 0 (came here by branch with !CO)
            // then we and the AluInA with 1 if zero mod3 is 2, else mod3 is 1
            begin
                CUconst     <= 8'd1;
                WE          <= 1'b1;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                InsSel      <= 2'd0;
                next_state  <= s_storemodreg5;
            end

            s_storemodreg5: // write the mod result into reg5 branching state
            begin // when we do the and operation 1 with the last result produced from the (A+B+C) 
                WE            <= 1'b0;
                if(Z) // if zero go into s_storemodreg5_Z
                    next_state <= s_storemodreg5_Z; 
                else // if not zero go into s_storemodreg5_NZ
                    next_state <= s_storemodreg5_NZ;
            end

            s_storemodreg5_Z: // result was 2 so store 2 into reg5 (mod3 is 2)
            begin
                CUconst  <= 8'd2;
                WE       <= 1'b1;
                InMuxAdd <= 3'd2;
                RegAdd   <= 4'd5;
                next_state <= s_store3const2;
            end

            s_storemodreg5_NZ: // the result was 1 so store it into reg5 (mod3 is 1)
            begin
                InMuxAdd <= 3'd3;
                WE       <= 1'b1;
                RegAdd   <= 4'd5;
                next_state <= s_store3const2;
            end

            s_store3const2: // 3 in decimal which is bits "11" into reg2 
            begin
                CUconst     <= 8'd3;
                WE          <= 1'b1;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                next_state  <= s_lookcarries;
            end

            s_lookcarries: // to understand if there was 0 carrys produced we and it with "11" 
            begin
                WE          <= 1'b1;
                OutMuxAdd   <= 4'd15;
                InMuxAdd    <= 3'd4;
                RegAdd      <= 4'd1;
                InsSel      <= 2'd0;
                next_state  <= s_andoperation;
            end

            s_andoperation: // if zero (because we and it 11 and the carry register had the value of 0 or 1 or 2) which
            // means there was no carry so we go into s_finish state
            // else we still have to check if there was 1 or 2 carries produced
            begin
                WE             <= 1'b0;
                if(Z)
                    next_state <= s_finish;
                else
                    next_state <= s_store2const;  
                       
            end

            s_store2const: // we and with 2 in decimal and "10" in bits
            begin
                CUconst     <= 8'd2;
                WE          <= 1'b1;
                InsSel      <= 2'd0;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                next_state  <= s_andoperation2;
            end

            s_andoperation2: // if zero produced which means the carry produced was 1 so we go into s_onecarryp branch
            // else means two carry produced we go into s_twocarryp branch
            begin
                WE             <= 1'b0;
                if(Z)
                    next_state <= s_onecarryp;
                else
                    next_state <= s_twocarryp;
            end

            s_onecarryp: // mod result from reg5 into reg1, reg2 has already 2 constant (10) from before
            // and and them with each other to know if there is a zero flag
            begin
                OutMuxAdd   <= 4'd5;
                InsSel      <= 2'd0;
                InMuxAdd    <= 3'd4;
                WE          <= 1'b1;
                RegAdd      <= 4'd1;
                next_state  <= s_onecarrymod;
            end

            s_onecarrymod: // this is for precision calculations if one carry was produced and the mod3 result & 2
                // would be zero and carry would do 255/3 = 85.33 and we know that result has the value something like .33 so 
                // the rounding will be floored because .33 + .33 = .67, if it is not zero which means the mod value is 2 and it
                // is something like .67 and the carry would be 85.33 so .33 + .67 which means the result must be increased by 1
            begin
                WE             <= 1'b0;
                if(Z)
                    next_state <= s_SET85;
                else
                    next_state <= s_SET86;
            end

            s_SET85: // set the CUconst 85
            begin
                WE          <= 1'b0;
                CUconst     <= 8'd85;
                next_state  <= s_sumwithcarry1;
            end

            s_SET86: // set the CUconst 86
            begin
                WE          <= 1'b0;
                CUconst     <= 8'd86;
                next_state  <= s_sumwithcarry1;
            end

            s_twocarryp: //mod result from reg5 into reg1
            begin
                OutMuxAdd   <= 4'd5;
                InMuxAdd    <= 3'd4;
                InsSel      <= 2'd0;
                WE          <= 1'b1;
                RegAdd      <= 4'd1;
                next_state  <= s_store3const3;
            end

            s_store3const3: //store 3 constant into reg2 and do the and operation
            begin
                CUconst     <= 8'd3;
                InMuxAdd    <= 3'd2;
                RegAdd      <= 4'd2;
                InsSel      <= 2'd0;
                WE          <= 1'b1;
                next_state  <= s_twocarrymod;
            end

            s_twocarrymod: // this is for precision calculations if two carry was produced and the mod3 result & 3
                // would be zero and carry would do (255/3)*2 = 170.67 and we know that result has the value has no mod .00 so 
                // the rounding will be floored because  .67, if it is not zero which means the mod value is either 2 or 1 and it
                // is something like .67 or .33 and the carry would be 170.76 so (.33 or .67) + .67 which means the result must be increased by 1
            begin
                WE         <= 1'b0;
                if(Z)
                    next_state <= s_SET170;   
                else
                    next_state <= s_SET171;
            end

            s_SET170: // set the CUconst 170
            begin
                WE         <= 1'b0;
                CUconst    <= 8'd170;
                next_state <= s_sumwithcarry1;
            end

            s_SET171: // set the CUconst 171
            begin
                WE         <= 1'b0;
                CUconst    <= 8'd171;
                next_state <= s_sumwithcarry1;
            end

            s_sumwithcarry1: // get the division result value from reg10 into reg1
            begin
                InMuxAdd    <= 3'd4;
                OutMuxAdd   <= 4'd10;
                WE          <= 1'b1;
                RegAdd      <= 4'd1;
                next_state  <= s_sumwithcarry2;
            end

            s_sumwithcarry2: // addition with the CUconst with division result value from reg10 
            begin       
                InMuxAdd    <= 3'd2; 
                WE          <= 1'b1;
                RegAdd      <= 4'd2;
                InsSel      <= 2'd2;
                next_state  <= s_resultintoreg10;
            end

            s_resultintoreg10: // result into REG10 again
            begin
                InMuxAdd    <= 3'd3;
                WE          <= 1'b1;
                RegAdd      <= 4'd10;
                next_state  <= s_finish;
            end

            s_finish: // result from REG10 into REG0(out)
            begin
                WE          <= 1'b1;
                InMuxAdd    <= 3'd4;
                OutMuxAdd   <= 4'd10;
                RegAdd      <= 4'd0;
                next_state  <= s_finished;
            end

            s_finished: // busy flag set to be 0 and go into s_idle state and reset all the used control registers
            begin
                CUconst     <= 8'dz;
                busy        <= 1'b0;
                WE          <= 1'b0;
                OutMuxAdd   <= 4'bz;
                RegAdd      <= 4'bz;
                InMuxAdd    <= 3'bz;
                InsSel      <= 2'bz;
                next_state  <= s_idle;
            end

            default:
                next_state <= s_idle;
                
        endcase
      end
endmodule
