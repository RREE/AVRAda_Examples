# Basic Examples to Start Programming on AVRs

These are simple examples to test or show single features of either
some onboard functionality or some Ada feature.

- `extern_int_main`: activate external interrupts on falling edge
- `flash_led`: blink a LED driven purely by timer, no active code
- `voltmeter`: read ADC value from `ADC0` and send raw value to the serial
  line. Probably requires an appropriate voltage divider (two
  resistors in series).
- `test_eeprom`: Accessing variables stored in internal EEPROM
- `hello_led`: basic port input/output technique. Turn on LED when key
  is pressed.
- `local_exception`: exceptions can be used if handled within the same
  subprogram.  If an exception is not handled the `last_chance_handler`
  will be called.
- `pwm_demo`: generate voltages between VCC and GND using Pulse Width
  Modulation (PWM). A LED with a series resistor should be connected
  from PD5 to GND.
- `walking_led_main`: use of timer/counter interrupts and walk a LED
  from bit 0 to 7
- `family_main`: Very basic use of tagged types and dispatching
