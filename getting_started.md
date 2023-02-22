## Getting Started

The simplest things to get you started are an Arduino board and a USB cable to connect it to your computer.

The typical "Hello World" program is a blinking LED in the embedded world.  The standard Arduino boards already have a LED between B5 (pin 5 of port B, labeled "D13" ) and ground.  You have to set the pin to high level to switch it on.

### Check out the Examples

The easiest way to get you going is to get the examples.  They will install the necessary compiler and environment with the help of Alire. 

So, first get the examples: 
```bash
alr get avrada_examples
```
step into the crate and then go into `delays`.  You now have to tell Alire about the dependencies. 

###  Install the Compiler Environment

That is done issuing the command 
```bash
cd avrada_examples_<ver>_<hash>/delays
alr update
```
It proposes to install 

- the cross compiler (`gnat_avr_elf`), 
- the compiler's minimal run time system (`avrada_rts`),
- the register definitions of the various supported AVR processors (`avrada_mcu`),
- and a library of drivers for the on-board peripherals like timers and useful functions like string manipulation (`avrada_lib`).

That already lists the four building blocks of AVR-Ada (see below). Simply hit the Enter key to confirm the choice and Alire will install the mentioned toolchain and the other crates.

### Compilation 

Simply run `alr build` or `make`. Alire and the GNAT project manager will compile, bind and link all the necessary files. It will show some warnings in `avr-real_time.adb` ('warning: unrecognized pragma "NOT_IMPLEMENTED"') as some procedures are not yet implemented. In the end you have built three programs `blink_busy.elf`, `blink_clock.elf`, and `blink_rel.elf`.

### Upload
You have to know which port is used in your OS for the connected Arduino. Probably it is something like `com1:` on Windows or `/dev/ttyUSB0` on Linux. Windows has a device manager if you are unsure. You have to set that port in the `Makefile` at line 67. Set the variable `AVRDUDE_PORT` to whatever the OS choose. 

You can then upload your program to the Arduino by
```bash
make blink_busy.prog
```
![blinky_arduino](https://user-images.githubusercontent.com/176057/210015363-2167e6fe-13fa-40d0-a17d-d25c086f5857.gif)
