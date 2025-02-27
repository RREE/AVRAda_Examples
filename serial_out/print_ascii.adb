---------------------------------------------------------------------------
-- The AVR-Ada Library is free software;  you can redistribute it and/or --
-- modify it under terms of the  GNU General Public License as published --
-- by  the  Free Software  Foundation;  either  version 2, or  (at  your --
-- option) any later version.  The AVR-Ada Library is distributed in the --
-- hope that it will be useful, but  WITHOUT ANY WARRANTY;  without even --
-- the  implied warranty of MERCHANTABILITY or FITNESS FOR A  PARTICULAR --
-- PURPOSE. See the GNU General Public License for more details.         --
--                                                                       --
-- As a special exception, if other files instantiate generics from this --
-- unit,  or  you  link  this  unit  with  other  files  to  produce  an --
-- executable   this  unit  does  not  by  itself  cause  the  resulting --
-- executable to  be  covered by the  GNU General  Public License.  This --
-- exception does  not  however  invalidate  any  other reasons why  the --
-- executable file might be covered by the GNU Public License.           --
---------------------------------------------------------------------------

with AVR;                          use AVR;
with AVR.Serial;                   
with AVR.Strings;                  use AVR.Strings;
with AVR.Strings.Edit;             use AVR.Strings.Edit;
with AVR.Strings.Edit.Integers;    use AVR.Strings.Edit.Integers;

procedure Print_Ascii is
   
   subtype Ascii_Range is Nat8 range 0 .. 127;
   subtype Printable is Ascii_Range range 32 .. 126;
   
begin
   Serial.Init (Serial.Baud_19200_16MHz);
   
   Serial.New_Line;
   Serial.Put_Line ("char | dec |    bin   | hex ");
   Serial.Put_Line ("----------------------------");
   
   for C in Ascii_Range loop
      --  re-initialize the global edit output buffer by setting the write
      --  pointer `Output_Last` to the first index of `Output_Line`.
      Output_Last := 1;
      
      --  put the character itself in the center of 5 characters
      if C in Printable then
	 Put (''', 2, Right);
	 Put (Character'Val(C));
	 Put (''', 2, Left);
      else
	 Put (" --- ");
      end if;
      Put ("| ");
      --  decimal output, right aligned
      Put (C, Base => 10, Field => 3, Justify => Right);
      Put (" | ");
      --  binary output, right aligned, padded left with zeroes
      Put (C, Base => 2, Field => 8, Justify => Right, Fill => '0');
      Put (" | ");
      --  hexadecimal output, right aligned, padded left with zeroes
      Put (C, Base => 16, Field => 2, Justify => Right, Fill => '0');
      --  add a final newline 
      New_Line;
      --  send the `Output_Line` to the serial port
      Serial.Put;
   end loop;

end Print_Ascii;
