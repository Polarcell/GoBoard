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

    if( r_place1 == 0 )       r_Segment1 <= 7'h7E;
    else if( r_place1 == 1 )  r_Segment1 <= 7'h30; 
    else if( r_place1 == 2 )  r_Segment1 <= 7'h6D; 
    else if( r_place1 == 3 )  r_Segment1 <= 7'h79; 
    else if( r_place1 == 4 )  r_Segment1 <= 7'h33; 
    else if( r_place1 == 5 )  r_Segment1 <= 7'h5B; 
    else if( r_place1 == 6 )  r_Segment1 <= 7'h5F; 
    else if( r_place1 == 7 )  r_Segment1 <= 7'h70; 
    else if( r_place1 == 8 )  r_Segment1 <= 7'h7F; 
    else if( r_place1 == 9 )  r_Segment1 <= 7'h7B; 
    else if( r_place1 == 10 ) r_Segment1 <= 7'h77; 
    else if( r_place1 == 11 ) r_Segment1 <= 7'h1F; 
    else if( r_place1 == 12 ) r_Segment1 <= 7'h4E; 
    else if( r_place1 == 13 ) r_Segment1 <= 7'h3D; 
    else if( r_place1 == 14 ) r_Segment1 <= 7'h4F; 
    else if( r_place1 == 15 ) r_Segment1 <= 7'h47; 
    else r_Segment1 = 7'h00;

    if( r_place2 == 0 )       r_Segment2 <= 7'h7E;
    else if( r_place2 == 1 )  r_Segment2 <= 7'h30; 
    else if( r_place2 == 2 )  r_Segment2 <= 7'h6D; 
    else if( r_place2 == 3 )  r_Segment2 <= 7'h79; 
    else if( r_place2 == 4 )  r_Segment2 <= 7'h33; 
    else if( r_place2 == 5 )  r_Segment2 <= 7'h5B; 
    else if( r_place2 == 6 )  r_Segment2 <= 7'h5F; 
    else if( r_place2 == 7 )  r_Segment2 <= 7'h70; 
    else if( r_place2 == 8 )  r_Segment2 <= 7'h7F; 
    else if( r_place2 == 9 )  r_Segment2 <= 7'h7B; 
    else if( r_place2 == 10 ) r_Segment2 <= 7'h77; 
    else if( r_place2 == 11 ) r_Segment2 <= 7'h1F; 
    else if( r_place2 == 12 ) r_Segment2 <= 7'h4E; 
    else if( r_place2 == 13 ) r_Segment2 <= 7'h3D; 
    else if( r_place2 == 14 ) r_Segment2 <= 7'h4F; 
    else if( r_place2 == 15 ) r_Segment2 <= 7'h47; 
    else r_Segment2 = 7'h00;
  end

  assign o_Segment1 = r_Segment1;  
  assign o_Segment2 = r_Segment2;  
endmodule 
