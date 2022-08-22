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

with AVR;
-- with AVR.Serial;
with Seven_Seg_Disp.Wiring;        use Seven_Seg_Disp.Wiring;
with Seven_Seg_Disp.Glyphs;

package body Seven_Seg_Disp is


   procedure Init
   is
      use AVR;
   begin
      Seg_A_DD   := DD_Output;
      Seg_B_DD   := DD_Output;
      Seg_C_DD   := DD_Output;
      Seg_D_DD   := DD_Output;
      Seg_E_DD   := DD_Output;
      Seg_F_DD   := DD_Output;
      Seg_G_DD   := DD_Output;
      Seg_Dot_DD := DD_Output;
   end Init;


   --  convert standard characters to display characters
   function "+" (C : Character) return Char_7Seg
   is
   begin
      case C is
      when '-' => return '-';
      when '0' => return '0';
      when '1' => return '1';
      when '2' => return '2';
      when '3' => return '3';
      when '4' => return '4';
      when '5' => return '5';
      when '6' => return '6';
      when '7' => return '7';
      when '8' => return '8';
      when '9' => return '9';
      when others => return ' ';
      end case;
   end "+";


   procedure Display (Val : Char_7Seg; Dot : Boolean := False)
   is
      use Seven_Seg_Disp.Glyphs;
   begin
      Seg_A   := Active_Segments (Val)(A);
      Seg_B   := Active_Segments (Val)(B);
      Seg_C   := Active_Segments (Val)(C);
      Seg_D   := Active_Segments (Val)(D);
      Seg_E   := Active_Segments (Val)(E);
      Seg_F   := Active_Segments (Val)(F);
      Seg_G   := Active_Segments (Val)(G);
      Seg_Dot := Dot;
   end Display;


   procedure Display (Val : Int_7Seg; Dot : Boolean := False)
   is
   begin
      if Val < 0 then
         Display (' ');
      else
         Display (Char_7Seg'Val(Char_7Seg'Pos('0')+Val), Dot);
      end if;
   end Display;


   procedure Display_Dot (Set : Boolean := True)
   is
   begin
      Seg_Dot := Set;
   end Display_Dot;

end Seven_Seg_Disp;
