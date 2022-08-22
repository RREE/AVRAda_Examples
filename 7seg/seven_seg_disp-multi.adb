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
with AVR.Strings;                  use AVR.Strings;
with AVR.Real_Time.Timing_Events;  use AVR.Real_Time.Timing_Events;
with Seven_Seg_Disp.Wiring;

package body Seven_Seg_Disp.Multi is


   E : aliased Timing_Event;

   Hold_Time : constant Real_Time.Duration := 0.005;

   Disp_Image : AStr4 with Volatile;
   Disp_Dot_Pos : Position_Range with Volatile;


   procedure Show_Digit_1 (Ev : access Timing_Event);
   procedure Show_Digit_2 (Ev : access Timing_Event);
   procedure Show_Digit_3 (Ev : access Timing_Event);
   procedure Show_Digit_4 (Ev : access Timing_Event);

   procedure Show_Digit_1 (Ev : access Timing_Event)
   is
      use Seven_Seg_Disp.Wiring;
   begin
      Dig_1_DD := DD_Output;
      Dig_2_DD := DD_Input;
      Dig_3_DD := DD_Input;
      Dig_4_DD := DD_Input;
      Dig_1 := Low;
      Display (+Disp_Image(4));
      Set_Handler (Ev, Hold_Time, Show_Digit_2'Access);
   end Show_Digit_1;

   procedure Show_Digit_2 (Ev : access Timing_Event)
   is
      use Seven_Seg_Disp.Wiring;
   begin
      Dig_1_DD := DD_Input;
      Dig_2_DD := DD_Output;
      Dig_3_DD := DD_Input;
      Dig_4_DD := DD_Input;
      Dig_2 := Low;
      Display (+Disp_Image(3));

      Set_Handler (Ev, Hold_Time, Show_Digit_3'Access);
   end Show_Digit_2;

   procedure Show_Digit_3 (Ev : access Timing_Event)
   is
      use Seven_Seg_Disp.Wiring;
   begin
      Dig_1_DD := DD_Input;
      Dig_2_DD := DD_Input;
      Dig_3_DD := DD_Output;
      Dig_4_DD := DD_Input;
      Dig_3 := Low;
      Display (+Disp_Image(2));

      Set_Handler (Ev, Hold_Time, Show_Digit_4'Access);
   end Show_Digit_3;

   procedure Show_Digit_4 (Ev : access Timing_Event)
   is
      use Seven_Seg_Disp.Wiring;
   begin
      Dig_1_DD := DD_Input;
      Dig_2_DD := DD_Input;
      Dig_3_DD := DD_Input;
      Dig_4_DD := DD_Output;
      Dig_4 := Low;
      Display (+Disp_Image(1));

      Set_Handler (Ev, Hold_Time, Show_Digit_1'Access);
   end Show_Digit_4;


   procedure Init (Nr_Of_Digits : Digits_Range := 4)
   is
      use AVR.Real_Time.Timing_Events;
   begin
      Seven_Seg_Disp.Init;
      Disp_Image := "    ";
      Disp_Dot_Pos := 0;

      Set_Handler (E'Access, 0.01, Show_Digit_1'Access);
   end Init;


   procedure Display (Val : Display_Value_Range; Position : Position_Range := 0)
   is
   begin
      null;
   end Display;


   procedure Display (Val : AStr4; Position : Position_Range := 0)
   is
   begin
      Disp_Image := Val;
   end Display;


   procedure Display_Dot (Position : Position_Range := 1)
   is
   begin
      null;
   end Display_Dot;

end Seven_Seg_Disp.Multi;
