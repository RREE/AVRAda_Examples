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

package Seven_Seg_Disp is

   --  7 segment displays are typically a single digit.  They have a
   --  common anode (or kathode).

   --  Characters that can be displayed on a single digit.  See
   --  https://en.wikipedia.org/wiki/Seven-segment_display#Characters
   --  for additional characters that you want to include.
   type Char_7Seg is (' ', '-',
                      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9');


   --  Numeric values that can be displayed on a single digit. -1 is
   --  used to indicate the blank (all off).
   subtype Int_7Seg is Integer range -1 .. 9;


   --  convert a standard characters to a display character
   function "+" (C : Character) return Char_7Seg;

   procedure Init;

   procedure Display (Val : Char_7Seg; Dot : Boolean := False);
   procedure Display (Val : Int_7Seg; Dot : Boolean := False);
   procedure Display_Dot (Set : Boolean := True);

end Seven_Seg_Disp;
