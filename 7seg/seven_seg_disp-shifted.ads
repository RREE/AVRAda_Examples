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

package Seven_Seg_Disp.Shifted is

   type Position_Range is range 1 .. 8 with Size => 8;

   type String8_7Seg is array (Position_Range) of Char_7Seg;
   type Dot_Array is array (Position_Range) of Boolean with Pack, Size => 8;
   No_Dots : constant Dot_Array := (others => False);


   procedure Init;

   procedure Display (Chars : String8_7Seg; Dots : Dot_Array := No_Dots);

end Seven_Seg_Disp.Shifted;
