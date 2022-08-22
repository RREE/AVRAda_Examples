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

with AVR.Strings;                  use AVR.Strings;

package Seven_Seg_Disp.Multi is

   --  Some 7-Seg displays combine up to 4 digits. They have a common
   --  anode (or kathode) per digit. Multiplexing drives one digit
   --  after another.
   type Digits_Range is range 2 .. 4;

   subtype Display_Value_Range is Integer range -999 .. 9999;
   subtype Position_Range is Integer range 0 .. 4;
   --  dot position 0 means no dot at all.

   procedure Init (Nr_Of_Digits : Digits_Range := 4);

   procedure Display (Val : AStr4; Position : Position_Range := 0);
   procedure Display (Val : Display_Value_Range; Position : Position_Range := 0);
   procedure Display_Dot (Position : Position_Range := 1);

end Seven_Seg_Disp.Multi;
