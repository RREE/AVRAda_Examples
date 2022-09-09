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

with Family;                       use Family;
with AVR;                          use AVR;
with AVR.UART;

procedure Family_Main is
   Mother : Family.Parent := Create (3);
   Son    : Family.Child  := Create (5);
begin
   UART.Init (UART.Baud_19200_16MHz);
   Mother.Image;
   Son.Image;
   declare
      Member_1 : constant Family.Parent'Class := Mother;
      Member_2 : constant Family.Parent'Class := Son;
   begin
      Member_1.Image;
      Member_2.Image;
   end;
end Family_Main;
