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
#TOP=LightOnRelease
#Written on FPGA Integrated Circuit
PACKAGE=vq100
#Provided by Nandland
CONSTRAINTS=Go_Board_Constraints.pcf

#TODO: Write a udev rule that standardizes this
#Found with lsusb and then taking bus/device
DEV=001/005

.PHONY: flashFPGA
flashFPGA: $(TOP).bin
				iceprog -d d:${DEV} $^
$(TOP).bin: $(TOP).asc
				icepack $^ $@
$(TOP).asc: $(TOP).json
				nextpnr-ice40 -q --hx1k --package $(PACKAGE) --freq 25 --top $(TOP) --pcf $(CONSTRAINTS) --json $^ --asc $@
$(TOP).json: $(TOP).v
				yosys -q -p "synth_ice40 -top $(TOP) -json $@" $^
.PHONY: clean
clean:
				rm -f $(TOP).json $(TOP).asc $(TOP).bin
