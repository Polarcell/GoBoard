#Makefile for my very first Verilog program using open source tools.
#I strongly dislike GNU make.  I think it encourages systems that are
#difficult to maintain by integrating regular expressions and not respecting
#the concept of working directory.  Maybe that's just the people who
#write Makefile tutorials though.  So, I'm going to try not to do that.

#Things I always forget because I don't use GNU make often enough:
#Last rule is at the top of the Makefile
#"Contents" of a rule MUST use TAB, not spaces!
#$@ = LHS of rule, $^ = RHS

#There's something about % that I don't remember atm
#There's something about patsubst that I don't remember atm

#The name of the program which shall match the name of the Verilog input file.
#TOP=SwitchesToLEDs
#Written on FPGA Integrated Circuit
PACKAGE=vq100

#Provided by Nandland
CONSTRAINTS=Go_Board_Constraints.pcf

#TODO: Write a udev rule that standardizes this
#Found with lsusb and then taking bus/device
DEV=001/007

.PHONY: flashFPGA
flashFPGA: $(TOP).bin
					iceprog -d d:${DEV} $^

$(TOP).bin: $(TOP).asc
	        icepack $^ $@

$(TOP).asc: $(TOP).blif
	        arachne-pnr -d 1k -o $@ -P $(PACKAGE) --pcf-file $(CONSTRAINTS) $^

$(TOP).blif: $(TOP).v
	        yosys -p "synth_ice40 -top $(TOP) -blif $@" $^

.PHONY: clean
clean:
	        rm $(TOP).blif $(TOP).asc $(TOP).bin
