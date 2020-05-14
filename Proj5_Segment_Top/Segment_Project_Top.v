`include "../Proj4_Debounce/Debounce_All_Switch.v"
`include "Segment_Display_Count.v"

module Segment_Project_Top
  (input i_Clk,
   input i_Switch_1,
   input i_Switch_2,
   input i_Switch_3,
   input i_Switch_4,
   output o_LED_1, 
   output o_LED_2,
   output o_LED_3,
   output o_LED_4,
   output o_Segment1_A,
   output o_Segment1_B,
   output o_Segment1_C,
   output o_Segment1_D,
   output o_Segment1_E,
   output o_Segment1_F,
   output o_Segment1_G,
   output o_Segment2_A,
   output o_Segment2_B,
   output o_Segment2_C,
   output o_Segment2_D,
   output o_Segment2_E,
   output o_Segment2_F,
   output o_Segment2_G );
   
  //NOTE: These are packed arrays, meaning the bits are next to each other
  // If the brackets are afterwards, these are unpacked arrays, meaning the info is 
  // spread out.  Unpacked cannot be passed to modules
  reg [3:0] r_LEDs     = 4'b0000;
  reg [3:0] r_Switches = 4'b0000;

  wire [3:0] w_Switches;

  reg  [6:0] r_Segment1 = 7'b1111110;
  reg  [6:0] r_Segment2 = 7'b1111110;

  wire [6:0] w_Segment1;
  wire [6:0] w_Segment2;

  //Counter of button presses
  parameter c_BUTTON_COUNT_LIMIT = 256;
  reg [7:0] r_Button_Count       = 0;

  //Instantiate Debounce Module
  Debounce_All_Switch Debounce_Inst
  (.i_Clk(i_Clk),
    .i_Switch_1(i_Switch_1),
    .i_Switch_2(i_Switch_2),
    .i_Switch_3(i_Switch_3),
    .i_Switch_4(i_Switch_4),
    .o_Switches(w_Switches));

  //Output Segment wires
  Segment_Display_Count SDisp_Count_Inst
  (.i_Clk(i_Clk), 
   .i_Count(r_Button_Count), 
   .o_Segment1(w_Segment1), 
   .o_Segment2(w_Segment2) );

  always @(posedge i_Clk)
  begin
    r_Switches <= w_Switches;

    r_Segment1 <= w_Segment1;
    r_Segment2 <= w_Segment2;

    // If switch 1 is pressed and released
    //   r_Switch_1 = 1
    //   i_Switch_1 = 0
    //     o_LED_1 = ~r_LED_1

    if (w_Switches[0] == 1'b0 && r_Switches[0] == 1'b1)
    begin
      r_LEDs[0] <= ~r_LEDs[0];
      r_Button_Count <= r_Button_Count+1;
    end

    if( w_Switches[1] == 1'b0 && r_Switches[1] == 1'b1)
    begin
      r_LEDs[1] <= ~r_LEDs[1];
      r_Button_Count <= r_Button_Count+1;
    end

    if( w_Switches[2] == 1'b0 && r_Switches[2] == 1'b1)
    begin
      r_LEDs[2] <= ~r_LEDs[2];
      r_Button_Count <= r_Button_Count+1;
    end
    
    if( w_Switches[3] == 1'b0 && r_Switches[3] == 1'b1)
    begin
      r_LEDs[3] <= ~r_LEDs[3];
      r_Button_Count <= r_Button_Count+1;
    end

    if(r_Button_Count == c_BUTTON_COUNT_LIMIT)
    begin
      r_Button_Count <= 0;
    end 
  end

  assign o_LED_1 = r_LEDs[0];
  assign o_LED_2 = r_LEDs[1];
  assign o_LED_3 = r_LEDs[2];
  assign o_LED_4 = r_LEDs[3];

  //Interesting.  The segments are not (so 0 is on, 1 is off)
  assign o_Segment1_A = ~r_Segment1[6];
  assign o_Segment1_B = ~r_Segment1[5];
  assign o_Segment1_C = ~r_Segment1[4];
  assign o_Segment1_D = ~r_Segment1[3];
  assign o_Segment1_E = ~r_Segment1[2];
  assign o_Segment1_F = ~r_Segment1[1];
  assign o_Segment1_G = ~r_Segment1[0];

  assign o_Segment2_A = ~r_Segment2[6];
  assign o_Segment2_B = ~r_Segment2[5];
  assign o_Segment2_C = ~r_Segment2[4];
  assign o_Segment2_D = ~r_Segment2[3];
  assign o_Segment2_E = ~r_Segment2[2];
  assign o_Segment2_F = ~r_Segment2[1];
  assign o_Segment2_G = ~r_Segment2[0];

endmodule
