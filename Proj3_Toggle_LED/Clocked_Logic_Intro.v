module Clocked_Logic_Intro
  (input i_Clk,
   input i_Switch_1,
   input i_Switch_2,
   input i_Switch_3,
   input i_Switch_4,
   output o_LED_1, 
   output o_LED_2,
   output o_LED_3,
   output o_LED_4 );
   
  reg r_LED_1    = 1'b0;
  reg r_LED_2    = 1'b0;
  reg r_LED_3    = 1'b0;
  reg r_LED_4    = 1'b0;
  reg r_Switch_1 = 1'b0;
  reg r_Switch_2 = 1'b0;
  reg r_Switch_3 = 1'b0;
  reg r_Switch_4 = 1'b0;
               
  always @ (posedge i_Clk)
    begin
      // If switch 1 is pressed and released
      //   r_Switch_1 = 1
      //   i_Switch_1 = 0
      //     r_Switch_1 & ~i_Switch_1 
      //  Switch LED on/off
      //    M LED
      //    0 0   0
      //    0 1   1
      //    1 0   1
      //    1 1   0
      r_Switch_1 <= i_Switch_1;
      r_Switch_2 <= i_Switch_2;
      r_Switch_3 <= i_Switch_3;
      r_Switch_4 <= i_Switch_4;

      //We could have used:
      // if( i_Switch_1 == 1'b0 && r_Switch_1 = 1'b1)
        // begin
        //   r_LED_1 <= ~r_LED_1
        // end


      r_LED_1    <= r_LED_1 ^ r_Switch_1 & ~i_Switch_1; 
      o_LED_1    <= r_LED_1 ^ r_Switch_1 & ~i_Switch_1; 
      r_LED_2    <= r_LED_2 ^ r_Switch_2 & ~i_Switch_2; 
      o_LED_2    <= r_LED_2 ^ r_Switch_2 & ~i_Switch_2; 
      r_LED_3    <= r_LED_3 ^ r_Switch_3 & ~i_Switch_3; 
      o_LED_3    <= r_LED_3 ^ r_Switch_3 & ~i_Switch_3; 
      r_LED_4    <= r_LED_4 ^ r_Switch_4 & ~i_Switch_4; 
      o_LED_4    <= r_LED_4 ^ r_Switch_4 & ~i_Switch_4; 
    end

endmodule
