Drive Hobby Servos
-----

This example shows how to drive a servos. Most hobby servos
go the neutral position at a pulse width of 1.5ms, to the left most
position at 1.0ms, and to the right most position at 2.0ms. See the
Wikipedia article about [servo
control](https://en.wikipedia.org/wiki/Servo_control) for a more
detailed discussion. The active pulse is to be repeated every 20ms. 

You can drive up to 8 servos as long as you connect their respective
control line all to the same port. The actual wiring is to be
configured in `servos-config.ads`. You have to set the AVR port to be
used in `Servo_Port` (actual I/O) and `Servo_DDR` (data direction
register). You then set the bit array `Servo_Is_Connected` for all
actually connected pins. The exaple uses port B and two servos as pins
1 and 2. Port B1 corresponds to Arduino pin D9 and port B2 to D10.

```Ada
   --           port     port pin      Arduino pin
   --  Front_L  PortB       2              D10
   --  Front_R  PortB       1              D9

   Servo_Port : Bits_In_Byte renames MCU.PORTB_Bits;
   Servo_DDR  : Bits_In_Byte renames MCU.DDRB_Bits;

   --  bit mask to indicate which pins will provide servo pulses.
   Servo_Is_Connected : constant array (Servo_Range) of Boolean :=
     (0 => False,
      1 => True,
      2 => True,
      3 => False,
      4 => False,
      5 => False,
      6 => False,
      7 => False);
```

You can use describing names in your main loop for the servos referencing the corresponding pin number, e.g. 

```Ada
Front_L : constant Servo_Range := 2;`
```

The position of a servo is defined to be in the range between -100 as
left most position to +100 as right most position. The mid position is
therefore 0. To set the position of a named servo use the command
`Set_Position` as in

```Ada
Set_Position (Front_L) := 50;
```

It will set the servo `Front_L` to a angle of about 45 degrees.





