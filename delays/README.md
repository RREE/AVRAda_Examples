Blinking an LED, the "Hello, World" in embedded computing
-----

Here we have three examples to make a blinking LED
1. `blink_busy.adb`, uses active counting of nop instructions from `AVR.Wait`
2. `blink_rel.adb`, uses Ada's relative `delay`
3. `blink_clock.adb`, comparison of current clock to target time with intermediate 1ms sleeps
