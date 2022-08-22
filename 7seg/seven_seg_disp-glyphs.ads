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


package Seven_Seg_Disp.Glyphs is


   type Segments is (A, B, C, D, E, F, G, Dot);


   type Glyph is array (Segments) of Boolean
   with Pack, Size => 8;


   Active_Segments : constant array (Char_7Seg) of Glyph :=
     ('-' => (A => False, B => False,C => False, D => False, E => False, F => False, G => True,  Dot => False),
      '0' => (A => True,  B => True, C => True,  D => True,  E => True,  F => True,  G => False, Dot => False),
      '1' => (A => False, B => True, C => True,  D => False, E => False, F => False, G => False, Dot => False),
      '2' => (A => True,  B => True, C => False, D => True,  E => True,  F => False, G => True,  Dot => False),
      '3' => (A => True,  B => True, C => True,  D => True,  E => False, F => False, G => True,  Dot => False),
      '4' => (A => False, B => True, C => True,  D => False, E => False, F => True,  G => True,  Dot => False),
      '5' => (A => True,  B => False,C => True,  D => True,  E => False, F => True,  G => True,  Dot => False),
      '6' => (A => True,  B => False,C => True,  D => True,  E => True,  F => True,  G => True,  Dot => False),
      '7' => (A => True,  B => True, C => True,  D => False, E => False, F => False, G => False, Dot => False),
      '8' => (A => True,  B => True, C => True,  D => True,  E => True,  F => True,  G => True,  Dot => False),
      '9' => (A => True,  B => True, C => True,  D => True,  E => False, F => True,  G => True,  Dot => False),
      others => (others => False));


end Seven_Seg_Disp.Glyphs;
