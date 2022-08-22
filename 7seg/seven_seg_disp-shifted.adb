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
with AVR.Wait;                     --use AVR.Wait;
with AVR.Real_Time.Timing_Events;  use AVR.Real_Time.Timing_Events;
with Seven_Seg_Disp.Glyphs;
with Seven_Seg_Disp.Shifted.Wiring;

package body Seven_Seg_Disp.Shifted is

   E         : aliased Timing_Event;
   Hold_Time : constant := 0.003;
   Pos_TE    : Position_Range;
   Global_Chars : String8_7Seg;
   Global_Dots  : Dot_Array;

   procedure Set_Data (Val : Boolean := True) with Inline;
   procedure Clock_Pulse;
   procedure Pulse_Char (Val : Char_7Seg; Dot : Boolean := False);
   procedure Pulse_Pos (Pos : Position_Range);


   procedure Show_Digit (Ev : access Timing_Event)
   is
   begin
      Pulse_Char (Global_Chars(Pos_TE), Global_Dots (Pos_TE));
      Pulse_Pos (Pos_TE);

      Pos_TE := (if Pos_TE < 8 then Pos_TE + 1 else 1);
      Set_Handler (Ev, Hold_Time, Show_Digit'Access);
   end Show_Digit;


   procedure Init
   is
      use Wiring;
   begin
      Clock_DD  := DD_Output;
      Data_DD   := DD_Output;
      Clock_Pin := Low;
      Data_Pin  := Low;

      Global_Chars := (others => ' ');
      Global_Dots  := No_Dots;
      Pos_TE       := 1;
      Set_Handler (E'Access, Hold_Time, Show_Digit'Access);
   end Init;


   procedure Display (Chars : String8_7Seg; Dots : Dot_Array := No_Dots)
   is
   begin
      Global_Chars := Chars;
      Global_Dots := Dots;
   end Display;


   procedure Wait_Pulse with Inline_Always;
   procedure Wait_Pulse is
   begin
      AVR.Wait.Wait_3_Cycles (1);
   end Wait_Pulse;



   procedure Clock_Pulse
   is
      use Wiring;
   begin
      Clock_Pin := High;
      Wait_Pulse;
      Clock_Pin := Low;
      Wait_Pulse;
   end Clock_Pulse;


   procedure Set_Data (Val : Boolean := True)
   is
      use Wiring;
   begin
      Data_Pin := Val;
   end Set_Data;


   procedure Pulse_Char (Val : Char_7Seg; Dot : Boolean := False)
   is
      use Seven_Seg_Disp.Glyphs;
   begin
      Set_Data (not Dot);
      Clock_Pulse;
      for Seg in reverse Segments range A .. G loop
         Set_Data (not Active_Segments (Val)(Seg));
         Clock_Pulse;
      end loop;
   end Pulse_Char;


   procedure Pulse_Pos (Pos : Position_Range)
   is
      P : constant Position_Range :=
        Position_Range (9 - Integer (Pos));
   begin
      Set_Data (False);
      for I in 2 .. P loop
         Clock_Pulse;
      end loop;
      Set_Data (True);
      Clock_Pulse;
      Set_Data (False);
      for I in P .. 7 loop
         Clock_Pulse;
      end loop;
   end Pulse_Pos;

end Seven_Seg_Disp.Shifted;
