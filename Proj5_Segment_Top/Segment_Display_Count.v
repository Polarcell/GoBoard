module Segment_Display_Count ( i_Clk, i_Count, o_Segment1, o_Segment2 );
  input i_Clk;
  input [7:0] i_Count;
  output [6:0] o_Segment1;
  output [6:0] o_Segment2;

  reg [6:0] r_Segment1 = 7'b1111110;  
  reg [6:0] r_Segment2 = 7'b1111110;  

  assign o_Segment1 = r_Segment1;  
  assign o_Segment2 = r_Segment2;  
endmodule 
