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

with Interfaces;                   use Interfaces;
with AVR;                          use AVR;
with AVR.MCU;                      use AVR.MCU;

package Debounce is

   Key_Input    : Unsigned_8 renames MCU.PIND;

   Repeat_Mask  : constant Unsigned_8 := PortD1_Mask or PortD2_Mask; -- repeat: key 1, 2
   Repeat_Start : constant := 125;             -- after 500ms (isr every 4ms)
   Repeat_Next  : constant :=  25;             -- every 100ms (isr every 4ms)

   function Get_Key_Press (Key_Mask : Unsigned_8) return Unsigned_8;

   function Get_Key_Rpt (Key_Mask : Unsigned_8) return Unsigned_8;

end Debounce;
