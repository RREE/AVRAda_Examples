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


--  Test external interrupts 0 and 1. They are triggered by a falling
--  edge on their respective external interrupt pins.  On the Arduino
--  that is port D2 (digital 2) for external interrupt 0 and port D3
--  (digital 3) for external interrupt 1.  Both interrupt routines
--  send corresponding debug messages to the serial port.

with AVR.UART;
with Extern_Int;

procedure Extern_Int_Main is
begin
   AVR.UART.Init (AVR.UART.Baud_19200_16MHz);
   AVR.UART.Put_Line("start test of external interrupts");
   Extern_Int.Init;

   loop null; end loop;                    -- loop for ever
end Extern_Int_Main;
