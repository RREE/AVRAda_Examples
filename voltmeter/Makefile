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

# MCU name
MCU := atmega328p

# GNAT project file
GPR := examples.gpr

# put the names of the target files here (without extension)
ADA_TARGETS := pwm_demo flash_led hello_led test_eeprom walking_led_main \
   test_starterkit_main extern_int_main test_progmem test_local_exception \
   endianness_demo test_tags


#---------------- GPRBUILD/GNATMAKE Options ----------------
MFLAGS = -XMCU=$(MCU) -p -P$(GPR)
# -p : Create missing obj, lib and exec dirs

#---------------- Programming Options (avrdude) ----------------
# Output format. (can be srec, ihex, binary)
FORMAT = ihex

#---------------- Programming Options (avrdude) ----------------

# Programming hardware: stk500v1 stk500v2 arduino
#
# Type: avrdude -c ?
# to get a full listing.
#
AVRDUDE_PROGRAMMER = arduino

# com1 = serial port.
# programmer connected to serial device, add -b 57600 for Arduinos
AVRDUDE_PORT = com5 -b 57600

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
SHELL    := sh
CC       := avr-gcc
OBJCOPY  := avr-objcopy
OBJDUMP  := avr-objdump
SIZE     := avr-size
NM       := avr-nm
AVRDUDE  := avrdude
REMOVE   := rm -f
COPY     := cp
RENAME   := mv
WINSHELL := cmd
GNATMAKE := gprbuild --target=avr
GPRBUILD := gprbuild --target=avr

# Combine all necessary flags and optional flags.
# Add target processor to flags.
ALL_ASFLAGS = -mmcu=$(MCU) -I. -x assembler-with-cpp $(ASFLAGS)


# Default target.
all: build

ADA_TARGETS_ELF = $(addsuffix .elf, $(ADA_TARGETS))
ADA_TARGETS_HEX = $(addsuffix .hex, $(ADA_TARGETS))
ADA_TARGETS_EEP = $(addsuffix .eep, $(ADA_TARGETS))
ADA_TARGETS_LSS = $(addsuffix .lss, $(ADA_TARGETS))
ADA_TARGETS_SYM = $(addsuffix .sym, $(ADA_TARGETS))
ADA_TARGETS_SIZE = $(addsuffix .size, $(ADA_TARGETS))

# Create the necessary sub-directories
SUBDIRS := obj


build: $(ADA_TARGETS_ELF) $(ADA_TARGETS_HEX) $(ADA_TARGETS_EEP) \
   $(ADA_TARGETS_LSS) $(ADA_TARGETS_SYM) $(ADA_TARGETS_SIZE)

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
	$(OBJDUMP) -h -S $< > $@

# Create a symbol table from ELF output file.
%.sym: %.elf
	$(NM) -n $< > $@

# --- build and link using gnatmake, force rebuilding by gnatmake to
#     make sure dependencies are resolved
%.elf: $(GPR) $(SUBDIRS) FORCE
	$(GNATMAKE) $(MFLAGS) -XAVRADA_MAIN=$*

# Compile: create assembler files from Ada source files.
%.s : %.adb
	$(GNATMAKE) -f -u $(MFLAGS) $< -cargs -S

%.s : %.ads
	$(GNATMAKE) -f -u $(MFLAGS) $< -cargs -S

# Assemble: create object files from assembler source files.
%.o : %.S
	$(CC) -c $(ALL_ASFLAGS) $< -o $@

# create the subdirectories
$(SUBDIRS):
	$(REMOVE) -r $@
	mkdir $@

# Target: clean project.
clean: clean_gnat clean_list

clean_gnat:
	avr-gnatclean -XMCU=$(MCU) -P$(GPR) $(ADA_TARGETS)

clean_gnat_recursive:
	avr-gnatclean -r -XMCU=$(MCU) -P$(GPR) $(ADA_TARGETS)

clean_list :
	$(REMOVE) *.hex
	$(REMOVE) *.eep
	$(REMOVE) *.elf
	$(REMOVE) *.map
	$(REMOVE) *.sym
	$(REMOVE) *.lss
	$(REMOVE) *.ali
	$(REMOVE) b~*.ad?
	$(REMOVE) -rf $(SUBDIRS)

FORCE:

# Listing of phony targets.
.PHONY : all finish \
   build elf hex eep lss sym clean clean_list program

-include $(Makefile_post)
