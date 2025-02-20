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


package Servos is

   --  set the actual wiring in Servos_Config for all servos that you
   --  use.

   --
   --  Servo Position
   --
   Full_Right_Position : constant  := +100;
   Mid_Position        : constant  :=    0;
   Full_Left_Position  : constant  := -100;

   type Position is range Full_Left_Position .. Full_Right_Position
     with Size => 8;

   --  only the index values as indicated in Servos_Config may and can
   --  be used.
   Max_Servos : constant := 8;
   type Servo_Range is mod Max_Servos;

   Servo_Position : array (Servo_Range) of Position;
   --  as the array elements are 8bit only, we don't need a "pragma
   --  Volatile".

   procedure Init;

end Servos;
