`include "Debounce_Switch.v"

module Debounce_Project_Top
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

  wire w_Switch_1;
  wire w_Switch_2;
  wire w_Switch_3;
  wire w_Switch_4;
              
  //Instantiate Debounce Module
  Debounce_Switch Debounce_Inst_1
  (.i_Clk(i_Clk),
   .i_Switch(i_Switch_1),
   .o_Switch(w_Switch_1));

  Debounce_Switch Debounce_Inst_2
  (.i_Clk(i_Clk),
   .i_Switch(i_Switch_2),
   .o_Switch(w_Switch_2));

  Debounce_Switch Debounce_Inst_3
  (.i_Clk(i_Clk),
   .i_Switch(i_Switch_3),
   .o_Switch(w_Switch_3));

  Debounce_Switch Debounce_Inst_4
  (.i_Clk(i_Clk),
   .i_Switch(i_Switch_4),
   .o_Switch(w_Switch_4));

  always @(posedge i_Clk)
  begin
    r_Switch_1 <= w_Switch_1;
    r_Switch_2 <= w_Switch_2;
    r_Switch_3 <= w_Switch_3;
    r_Switch_4 <= w_Switch_4;

    // If switch 1 is pressed and released
    //   r_Switch_1 = 1
    //   i_Switch_1 = 0
    //     o_LED_1 = ~r_LED_1

    // This conditional expression looks for a falling edge on w_Switch_1.
    // Here, the current value (i_Switch_1) is low, but the previous value
    // (r_Switch_1) is high.  This means that we found a falling edge.
    if (w_Switch_1 == 1'b0 && r_Switch_1 == 1'b1)
    begin
      r_LED_1 <= ~r_LED_1;
    end

    if( w_Switch_2 == 1'b0 && r_Switch_2 == 1'b1)
    begin
      r_LED_2 <= ~r_LED_2;
    end

    if( w_Switch_3 == 1'b0 && r_Switch_3 == 1'b1)
    begin
      r_LED_3 <= ~r_LED_3;
    end
    
    if( w_Switch_4 == 1'b0 && r_Switch_4 == 1'b1)
    begin
      r_LED_4 <= ~r_LED_4;
    end
  end

  assign o_LED_1 = r_LED_1;
  assign o_LED_2 = r_LED_2;
  assign o_LED_3 = r_LED_3;
  assign o_LED_4 = r_LED_4;


endmodule
