# GoBoard
Place for working on GoBoard code.  Nandland has an IDE that requires registration to get.  It was the weekend, so we decided on open source.  May head back that way for testbench purposes.

-We're using icestorm, found at http://www.clifford.at/icestorm/  Below is what Andrew did to get project 1 to work

# Andrew's setup for using Linx Icecube tools

##Packages needed
- `nextpnr` does place and route `git clone https://github.com/YosysHQ/nextpnr.git`
- `yosys` does "synthesis": `git clone https://github.com/cliffordwolf/yosys.git`
- `fpga-icestorm` seems like it gives me the command that flashes a program onto the FPGA `git clone https://github.com/cliffordwolf/icestorm.git`
-Need to look at the git pages for the correct setup

##Things I had to do differently
- I didn't use IceCube or Diamond because they require licenses and it's Saturday
- I **can't** rename ports.  They must match the .pcf file apparently.
- I had to tell arachne-pnr that it's dealing with a "VQ100" board and not whatever the default is ("tq144")

For the following examples, we're assuming the program's name is `Switches_To_LEDs`

##Successful workflow
- Synthesis: `yosys -q -p "synth_ice40 -top Switches_To_LEDs -json Switches_To_LEDs.json" Switches_To_LEDs.v`
- `-q` is the quiet option.  TURN THIS OFF IN THE BEGINNING
- `synth_ice40` tells the architecture
- `Switches_To_LEDs.v` is input
- `Switches_To_LEDs.json` is the output
- End of happy output without `-q`:
```
2.49. Printing statistics.

=== Switches_To_LEDs ===

Number of wires:                  8
Number of wire bits:              8
Number of public wires:           8
Number of public wire bits:       8
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:                  0

2.50. Executing CHECK pass (checking for obvious problems).
checking module Switches_To_LEDs..
found and reported 0 problems.

2.51. Executing JSON backend.

End of script. Logfile hash: 9cbc9df87c, CPU: user 0.28s system 0.02s, MEM: 51.34 MB peak
Yosys 0.9+2406 (git sha1 aafaeb6, clang 3.8.0-2ubuntu4 -fPIC -Os)
```
- Place and Route: `nextpnr-ice40 -q --hx1k --package vq100  --freq 25 --top Switches_To_LEDs --pcf Go_Board_Constraints.pcf --json Switches_To_LEDs --asc Switches_To_LEDs.asc`
- `vq100` is the board architecture
- `--freq 25` says the board is 25 MHz.  Don't mess with this
- `--pcf ` is a constraint file.  `Go_Board_Constraints.pcf` is available on the Nandland website: https://www.nandland.com/goboard/Go_Board_Constraints.pcf
  - End of happy output: 
```
Info: Routing..
Info: Setting up routing queue.
Info: Routing 4 arcs.
Info:            |   (re-)routed arcs  |   delta    | remaining|       time spent     |
Info:    IterCnt |  w/ripup   wo/ripup |  w/r  wo/r |      arcs| batch(sec) total(sec)|
Info:          4 |        0          4 |    0     4 |         0|       0.00       0.00|
Info: Routing complete.
Info: Router1 time 0.00s
Info: Checksum: 0xf3a28405
Warning: No clocks found in design

Info: Critical path report for cross-domain path '<async>' -> '<async>':
Info: curr total
Info:  0.0  0.0  Source i_Switch_2$sb_io.D_IN_0
Info:  1.6  1.6    Net o_LED_2$SB_IO_OUT budget 40.000000 ns (13,3) -> (13,7)
Info:                Sink o_LED_2$sb_io.D_OUT_0
Info: 0.0 ns logic, 1.6 ns routing

Info: Max delay <async> -> <async>: 1.59 ns

Info: Slack histogram:
Info:  legend: * represents 1 endpoint(s)
Info:          + represents [1,1) endpoint(s)
Info: [ 38411,  38443) |* 
Info: [ 38443,  38475) | 
Info: [ 38475,  38507) | 
Info: [ 38507,  38539) | 
Info: [ 38539,  38571) | 
Info: [ 38571,  38603) | 
Info: [ 38603,  38635) | 
Info: [ 38635,  38667) | 
Info: [ 38667,  38699) | 
Info: [ 38699,  38731) |* 
Info: [ 38731,  38763) | 
Info: [ 38763,  38795) | 
Info: [ 38795,  38827) | 
Info: [ 38827,  38859) | 
Info: [ 38859,  38891) | 
Info: [ 38891,  38923) | 
Info: [ 38923,  38955) | 
Info: [ 38955,  38987) | 
Info: [ 38987,  39019) | 
Info: [ 39019,  39051) |** 
```
- Examine output (not on Nandland)
  - `icepack SwitchesToLEDs.asc SwitchesToLEDs.bin`
  - `icebox_explain SwitchesToLEDs.asc`
  - `icebox_vlog -p Go_Board_Constraints.pcf SwitchesToLEDs.asc`
- Program the FPGA board
  - Get the "device node":
```lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 0403:6010 Future Technology Devices International, Ltd FT2232C Dual USB-UART/FIFO IC
Bus 001 Device 004: ID 8087:0025 Intel Corp. 
Bus 001 Device 003: ID 0c45:6717 Microdia 
Bus 001 Device 002: ID 0a5c:5832 Broadcom Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub```
```
  - Actually do the programming: `sudo iceprog -d d:001/005 SwitchesToLEDs.bin`
    - `sudo` needed because mere mortals (i.e. not root) can't access sketchy new USB devices
    - TODO: Create a "udev rule" so that mortals such as I can access my FPGA.  Think of the ProtoDUNE CRT...
    - Happy output:
      ```init..
cdone: high
reset..
cdone: low
flash ID: 0x20 0x20 0x11 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
file size: 32220
erase 64kB sector at 0x000000..
programming..
reading..
VERIFY OK
cdone: high
Bye.
```
- Check that it works: Push buttons and see LEDs turn on.  Match video on Nandland website.
