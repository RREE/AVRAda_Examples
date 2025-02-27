###########################################################################
## The AVR-Ada Library is free software;  you can redistribute it and/or ##
## modify it under terms of the  GNU General Public License as published ##
## by  the  Free Software  Foundation;  either  version 2, or  (at  your ##
## option) any later version.  The AVR#Ada Library is distributed in the ##
## hope that it will be useful, but  WITHOUT ANY WARRANTY;  without even ##
## the  implied warranty of MERCHANTABILITY or FITNESS FOR A  PARTICULAR ##
## PURPOSE. See the GNU General Public License for more details.         ##
###########################################################################

# This makefile is adapted from the sample Makefile of WinAVR by Eric
# B. Wedington, Jörg Wunsch and others.  As they released it to the
# Public Domain, I could pretend that I wrote it myself.  Honestly, I
# removed many (probably useful) parts to better fit the GNAT project makes.
#

# On command line:
#
# make all = Make software.
#
# make clean = Clean out built project files.
#
# make file.prog = Upload the hex file to the device, using avrdude.
#                Please customize the avrdude settings below first!
#
# make filename.s = Just compile filename.adb into the assembler code only.
#
#
# To rebuild project do "make clean" then "make all".
#----------------------------------------------------------------------------

-include $(Makefile_pre)


#
# setting the MCU in alire.toml as a shell command
#
# $ sed -i~ 's/^ *avrada_rts.avr_mcu.*/avrada_rts.AVR_MCU = \"attiny85\"/I' alire.toml
#
# it assumes that there is only a single line in alire.toml that
# matches. The final I makes the search regexp case ignoring

#------------------- device chip (MCU) -------------------------
# reading the device chip from alire.toml
MCU := $(shell awk -F= 'tolower($$0) ~ /^ *avrada_rts.avr_mcu/ {print $$2;}' alire.toml | xargs)

#---------------- Programming Options (avrdude) ----------------
# Output format. (can be srec, ihex, binary)
FORMAT = ihex

#---------------- Programming Options (avrdude) ----------------

# Programming hardware: alf avr910 avrisp bascom bsd
# dt006 pavr picoweb pony-stk200 sp12 stk200 stk500
#
# Type: avrdude -c ?
# to get a full listing.
#
AVRDUDE_PROGRAMMER = stk500v1 -b 57600

# com1 = serial port.
# programmer connected to serial device, add -b 57600 for Arduinos
AVRDUDE_PORT = /dev/ttyUSB0
AVRDUDE_WRITE_FLASH = -U flash:w:
AVRDUDE_WRITE_EEPROM = -U eeprom:w:

# Uncomment the following if you want avrdude's erase cycle counter.
# Note that this counter needs to be initialized first using -Yn,
# see avrdude manual.
#AVRDUDE_ERASE_COUNTER = -y

# Uncomment the following if you do /not/ wish a verification to be
# performed after programming the device.
#AVRDUDE_NO_VERIFY = -V

# Increase verbosity level.  Please use this when submitting bug
# reports about avrdude. See <http://savannah.nongnu.org/projects/avrdude>
# to submit bug reports.
#AVRDUDE_VERBOSE = -v -v

AVRDUDE_FLAGS = -p $(MCU) -P $(AVRDUDE_PORT) -c $(AVRDUDE_PROGRAMMER)
AVRDUDE_FLAGS += $(AVRDUDE_NO_VERIFY)
AVRDUDE_FLAGS += $(AVRDUDE_VERBOSE)
AVRDUDE_FLAGS += $(AVRDUDE_ERASE_COUNTER)

#============================================================================

# Define programs and commands.
BUILD    := alr build
CC       := alr exec -- avr-gcc
OBJCOPY  := alr exec -- avr-objcopy
OBJDUMP  := alr exec -- avr-objdump
SIZE     := /usr/bin/avr-size
# the standard Debian AVR binutils-size has Eric's old AVR size patch
NM       := alr exec -- avr-nm
AVRDUDE  := avrdude
REMOVE   := rm -f
COPY     := cp
RENAME   := mv
SED      := sed
WINSHELL := cmd



# Default target.

all:
	$(BUILD)

# create assembler files from Ada source files.
%.s : %.adb
	alr exec -P2 -- gprbuild -f -u $< -cargs -S

%.s : %.ads
	alr exec -P2 -- gprbuild -f -u $< -cargs -S

%.size: %.elf FORCE
	$(SIZE) --format=avr --mcu=$(MCU) $<

# Program the device.
%.prog: %.hex %.eep
	$(AVRDUDE) $(AVRDUDE_FLAGS) $(AVRDUDE_WRITE_FLASH)$*.hex
# $(AVRDUDE_WRITE_EEPROM)

# Create final output files (.hex, .eep) from ELF output file.
%.hex: %.elf
	$(OBJCOPY) -O $(FORMAT) -R .eeprom $< $@

%.eep: %.elf
	-$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom="alloc,load" \
	--change-section-lma .eeprom=0 -O $(FORMAT) $< $@

# Create extended listing file from ELF output file.
%.lss: %.elf
	$(OBJDUMP) --headers --source $< > $@

# Create a symbol table from ELF output file.
%.sym: %.elf
	$(NM) -n $< > $@

clean: clean_list
	alr clean

clean_list:
	$(REMOVE) *.hex
	$(REMOVE) *.eep
	$(REMOVE) *.elf
	$(REMOVE) *.map
	$(REMOVE) *.sym
	$(REMOVE) *.lss
	$(REMOVE) *.ali
	$(REMOVE) b~*.ad?

FORCE:

# Listing of phony targets.
.PHONY : all build elf hex eep lss sym clean clean_list

-include $(Makefile_post)
