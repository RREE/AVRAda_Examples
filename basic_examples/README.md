# Basic Examples to Start Programming on AVRs

These are simple examples to test or show single features of either
some onboard functionality or some Ada feature.

- `extern_int_main`: activate external interrupts on falling edge
- `flash_led`: blink a LED driven purely by timer, no active code
- `voltmeter`: read ADC value from `ADC0` and send raw value to the serial
  line. Most probably requires an appropriate voltage divider (two
  resistors in series).
- `test_eeprom`: Accessing variables stored in internal EEPROM
