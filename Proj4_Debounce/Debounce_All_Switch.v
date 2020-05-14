///////////////////////////////////////////////////////////////////////////////
// File downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
// This module is used to debounce any switch or button coming into the FPGA.
// Does not allow the output of the switch to change unless the switch is
// steady for enough time (not toggling).
///////////////////////////////////////////////////////////////////////////////
module Debounce_All_Switch ( i_Clk, i_Switch_1, i_Switch_2, i_Switch_3, i_Switch_4, o_Switches );
  input i_Clk;
  input i_Switch_1;
  input i_Switch_2;
  input i_Switch_3;
  input i_Switch_4;
  output [3:0] o_Switches;
  //Count clock ticks
  parameter c_DEBOUNCE_LIMIT = 250000;  // 10 ms at 25 MHz

  //18 bin register
  // Cannot put these into one unpacked array, does not allow for initialization
  reg [17:0] r_Count_1 = 0; 
  reg [17:0] r_Count_2 = 0; 
  reg [17:0] r_Count_3 = 0; 
  reg [17:0] r_Count_4 = 0; 

  reg [3:0] r_States = 4'b0000; 
               
  always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch_1 !== r_States[0] && r_Count_1 < c_DEBOUNCE_LIMIT)
      r_Count_1 <= r_Count_1 + 1;

    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count_1 == c_DEBOUNCE_LIMIT)
    begin
        r_States[0] <= i_Switch_1;
        r_Count_1 <= 0;
    end

    // Switches are the same state, reset the counter
    else
      r_Count_1 <= 0;
  end

  always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch_2 !== r_States[1] && r_Count_2 < c_DEBOUNCE_LIMIT)
      r_Count_2 <= r_Count_2 + 1;

    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count_2 == c_DEBOUNCE_LIMIT)
    begin
        r_States[1] <= i_Switch_2;
        r_Count_2 <= 0;
    end

    // Switches are the same state, reset the counter
    else
      r_Count_2 <= 0;
  end

  always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch_3 !== r_States[2] && r_Count_3 < c_DEBOUNCE_LIMIT)
      r_Count_3 <= r_Count_3 + 1;

    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count_3 == c_DEBOUNCE_LIMIT)
    begin
        r_States[2] <= i_Switch_3;
        r_Count_3 <= 0;
    end

    // Switches are the same state, reset the counter
    else
      r_Count_3 <= 0;
  end

  always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch_4 !== r_States[3] && r_Count_4 < c_DEBOUNCE_LIMIT)
      r_Count_4 <= r_Count_4 + 1;

    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count_4 == c_DEBOUNCE_LIMIT)
    begin
        r_States[3] <= i_Switch_4;
        r_Count_4 <= 0;
    end

    // Switches are the same state, reset the counter
    else
      r_Count_4 <= 0;
  end

  // Assign internal register to output (debounced!)
  assign o_Switches = r_States;
endmodule
