Strings Edit and Serial Output
-----

We reimplemented parts of Dmitry Kazakov's [Strings
Edit](https://www.dmitry-kazakov.de/ada/strings_edit.htm) package for
text strings (`AVR_String`) and integer values. The main difference is
the use of a library level variable for string output
`Output_Line`. It is a buffer of 60 characters for generating the
output before actually sending it to the UART (or a display). If you
need a bigger buffer you can set `Edit_Buffer_Length` in
`avr-strings-edit.ads` accordingly. The write pointer is called
`Output_Last`. Using a global variable here simplifies argument
passing and reduces code size.

The API for using AVR strings edit is defined in the files:
- `avr-strings-edit.ads`, declares the aforementioned `Output_Line`
  and `Output_Last`, various forms of `Put` for characters and
  strings. There is a generic procedure `Flush_Output` that needs a
  routine for output of a single character as its generic parameter.

- `avr-strings-edit-generic_integers.ads`, declares among some helper
  routines the two generic procedures `Generic_Put_I` for signed
  integers and `Generic_Put_U` for unsigned modular types. Both
  procedures rely on the internal routine `Put_U32` that places an
  unsigned number in a string buffer of 11 characters. That buffer is
  big enough to hold all figures of `Unsigned_32'Last` in base 10
  (2<sup>32</sup> = 4294967296<sub>10</sub>). Obviously, the biggest
  number in base 2 is 2<sup>11</sup>-1 = 2047<sub>10</sub> =
  111 1111 1111<sub>2</sub>.

- `avr-strings-edit-integers.ads` has instantiations of the generic
  output routines for the types `Integer_32`, `Integer_16`,
  `Integer_8`, `Unsigned_32`, `Unsigned_16`, and `Unsigned_8`;
  
The API for serial output via an USART (or UART on older devices) is
defined in the spec of `AVR.Serial`, the actual code is in
- `avr-serial_polled.ads`. It defines some constants that you have to
  use according to your board.  The standard Arduino boards run at
  16MHz, so you have to select a constant that ends in `_16MHz`. You
  can use several variations of `Put`, most notably a standard
  AVR_String (`procedure Put (S : AVR_String)`) and a string stored in
  flash memory (`procedure Put (S : PM_String)`). A simple `Put`
  without any arguments flushes the `Output_Line` from the strings
  edit package.
