We provide three examples of different 7 segment displays.

1. A single digit with a common cathode. You have to specify the port
   pins in `seven_seg_disp-wiring.ads`. Put a resistor of 220 or 330
   ohms between the common cathode and the ground,

2. A four digit display with common cathods per digit.  Specify the
   segment pins and the cathode pins in the same configuration file as
   for a single digit (`seven_seg_disp-wiring.ads`).  The implementation
   has to cycle through all digits, activate the cathode and set the
   segments.  Each digit is active for 5 milliseconds. The human eye
   cannot see the flickering.  As each digit is only activated during
   25% of the time you should reduce the resistors for the cathods to
   something like 47 Ohms.

3. An eight digit display (two rows of four digits) with common anode
   per digit and connected via two shifting serial to parallel chips
   (74HC164).  The value of the data pin is shifted in with every low
   to high edge.

Examples 2 and 3 make use of Ada timing events. Triggering timing
events was moved to the 1ms tick routine. Therefore the code of the
timing events is performed within the timer interrupt. See the config
in `alire.toml`.