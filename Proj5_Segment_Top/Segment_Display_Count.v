module Segment_Display_Count ( i_Clk, i_Count, o_Segment1, o_Segment2 );
  input i_Clk;
  input [7:0] i_Count;
  output [6:0] o_Segment1;
  output [6:0] o_Segment2;

  reg [6:0] r_Segment1 = 7'b1111110;  
  reg [6:0] r_Segment2 = 7'b1111110;  
  
  reg [3:0] r_place1 = 4'h00;
  reg [3:0] r_place2 = 4'h00;

  always @(posedge i_Clk)
  begin
    r_place1[3] <= i_Count[7]; 
    r_place1[2] <= i_Count[6];  
    r_place1[1] <= i_Count[5];  
    r_place1[0] <= i_Count[4];  
    r_place2[3] <= i_Count[3];  
    r_place2[2] <= i_Count[2];  
    r_place2[1] <= i_Count[1];  
    r_place2[0] <= i_Count[0];  
      
    case (r_place1)
      0  : r_Segment1 <= 7'h7E;
      1  : r_Segment1 <= 7'h30; 
      2  : r_Segment1 <= 7'h6D; 
      3  : r_Segment1 <= 7'h79; 
      4  : r_Segment1 <= 7'h33; 
      5  : r_Segment1 <= 7'h5B; 
      6  : r_Segment1 <= 7'h5F; 
      7  : r_Segment1 <= 7'h70; 
      8  : r_Segment1 <= 7'h7F; 
      9  : r_Segment1 <= 7'h7B; 
      10 : r_Segment1 <= 7'h77; 
      11 : r_Segment1 <= 7'h1F; 
      12 : r_Segment1 <= 7'h4E; 
      13 : r_Segment1 <= 7'h3D; 
      14 : r_Segment1 <= 7'h4F; 
      15 : r_Segment1 <= 7'h47; 
    endcase

    case (r_place2)
      0  : r_Segment2 <= 7'h7E;
      1  : r_Segment2 <= 7'h30; 
      2  : r_Segment2 <= 7'h6D; 
      3  : r_Segment2 <= 7'h79; 
      4  : r_Segment2 <= 7'h33; 
      5  : r_Segment2 <= 7'h5B; 
      6  : r_Segment2 <= 7'h5F; 
      7  : r_Segment2 <= 7'h70; 
      8  : r_Segment2 <= 7'h7F; 
      9  : r_Segment2 <= 7'h7B; 
      10 : r_Segment2 <= 7'h77; 
      11 : r_Segment2 <= 7'h1F; 
      12 : r_Segment2 <= 7'h4E; 
      13 : r_Segment2 <= 7'h3D; 
      14 : r_Segment2 <= 7'h4F; 
      15 : r_Segment2 <= 7'h47; 
    endcase

  end

  assign o_Segment1 = r_Segment1;  
  assign o_Segment2 = r_Segment2;  
endmodule 
