# GoBoard
Place for working on git code
We're using icestorm, found at http://www.clifford.at/icestorm/
Below is what Andrew did to get project 1 to work

# Andrew's setup for using Linux Icecube tools

##Packages I needed from `apt`
- `arachne-pnr` does place and route
- `yosys` does "synthesis"
- `fpga-icestorm` seems like it gives me the command that flashes a program onto the FPGA

##Things I had to do differently
- I didn't use IceCube or Diamond because they require licenses and it's Saturday
- I had to take out the "ports" I'm not using from the .pcf file because: `Go_Board_Constraints.pcf:16: fatal error: no port 'i_Clk' in top-level module 'SwitchesToLEDs'`
- I **can't** rename ports.  They must match the .pcf file apparently.
- I had to tell arachne-pnr that it's dealing with a "VQ100" board and not whatever the default is ("tq144")

##Successful workflow
- Synthesis: `yosys -p 'synth_ice40 -top SwitchesToLEDs -blif SwitchesToLEDs.blif' SwitchesToLEDs.v`
  - End of happy output:
```2.27. Printing statistics.

=== SwitchesToLEDs ===

   Number of wires:                  8
   Number of wire bits:              8
   Number of public wires:           8
   Number of public wire bits:       8
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  0

2.28. Executing CHECK pass (checking for obvious problems).
checking module SwitchesToLEDs..
found and reported 0 problems.

2.29. Executing BLIF backend.

End of script. Logfile hash: 649a1b8bf8
CPU: user 0.12s system 0.00s, MEM: 64.40 MB total, 37.24 MB resident
Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os)
Time spent: 55% 9x read_verilog (0 sec), 16% 1x share (0 sec), ...
```
- Place and Route: `arachne-pnr -d 1k -o SwitchesToLEDs.asc -P vq100 --pcf-file Go_Board_Constraints.pcf SwitchesToLEDs.blif`
  - End of happy output: 
```place_constraints...
promote_globals...
  promoted 0 nets
  0 globals
realize_constants...
place...
  initial wire length = 11
  at iteration #50: temp = 7.92282, wire length = 11
  final wire length = 11

After placement:
PIOs       5 / 72
PLBs       0 / 160
BRAMs      0 / 16

  place time 0.00s
route...
  pass 1, 0 shared.

After routing:
span_4     6 / 6944
span_12    0 / 1440

  route time 0.01s
write_txt SwitchesToLEDs.asc...
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
