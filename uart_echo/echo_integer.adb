with AVR;                          use AVR;
with AVR.UART;                     use AVR.UART;
with AVR.Strings;                  use AVR.strings;
with AVR.Int_Img;                  use AVR.Int_Img;

with Interfaces; use Interfaces;

procedure echo_integer is
   num   : Unsigned_8 := 125;
   str     : AVR_String := "   ";
   charCount : Unsigned_8;
begin
    Init (Baud_19200_16MHz);

   Put_Line ("start UART out");

   loop
      -- str(1..3) is an array slice,
      -- it is here to allow the function to
      -- write the characters to a string
      -- with a length greater than 3
      U8_Img(num, str(1..3), charCount);
      put(Str);
      New_Line;
   end loop;

end echo_integer;
