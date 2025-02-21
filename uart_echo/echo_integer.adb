with AVR;                          use AVR;
with AVR.UART;                     use AVR.UART;
with AVR.Strings;                  use AVR.strings;

with Interfaces; use Interfaces;
with naturalLog; use naturalLog;

procedure echo_integer is

   function intToAvrString (num : Integer) return AVR_String is
      digitCount : Unsigned_8;
   begin
      if num=0 then
         digitCount := 0;
      else
          digitCount := Unsigned_8(ln(float(abs(num))) / ln(10.0))+1;
      end if;


      declare
         result : AVR_String(1 .. digitCount);
         temp   : Integer := num;
      begin
         -- Fill the string in reverse order
         for i in reverse 1 .. digitCount loop
            result(i) := Character'Val(48 + (temp mod 10));
            temp := temp / 10;
         end loop;
         return Result;
      end;

   end intToAvrString;



   exampleInt : Integer := 210;
begin
    Init (Baud_19200_16MHz);

   Put_Line ("start UART out");

   loop
      put(intToAvrString(exampleInt));
      New_Line;
   end loop;

end echo_integer;
