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
with AVR.Real_Time.Clock;
pragma Unreferenced (AVR.Real_Time.Clock);
with Servos;                       use Servos;

procedure Main is
   Front_L : constant Servo_Range := 2;
   Front_R : constant Servo_Range := 1;
begin
   Servos.Init;
   
   --  set start position
   Servo_Position (Front_L) := Mid_Position;
   Servo_Position (Front_R) := Mid_Position;

   delay 1.0;

   loop
      Servo_Position (Front_L) := Full_Left_Position;
      Servo_Position (Front_R) := Full_Left_Position;

      --  slowly move from full left to full right
      for P in Servos.Position loop
         Servo_Position(Front_L) := P;
         Servo_Position(Front_R) := P;
         delay 0.1;
      end loop;

      delay 1.0;

      Servo_Position (Front_L) := Mid_Position;
      Servo_Position (Front_R) := Mid_Position;

      delay 1.0;

   end loop;
end Main;
