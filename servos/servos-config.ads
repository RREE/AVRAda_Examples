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
with AVR.MCU;

package Servos.Config is

   --  The Ladyada motor shield for Arduino
   --  (http://www.ladyada.net/make/mshield) provides two jacks for
   --  direct connection of standard hobby servos.  The data pins are:
   --
   --           port  port pin         Arduino pin
   --  Front_L  PortB       2              D10
   --  Front_R  PortB       1              D9
   --

   Servo_Port : Bits_In_Byte renames MCU.PORTB_Bits;
   Servo_DDR  : Bits_In_Byte renames MCU.DDRB_Bits;

   --  bit mask to indicate which pins will provide servo pulses.
   Servo_Is_Connected : constant array (Servo_Range) of Boolean :=
     (0 => False,
      1 => True,
      2 => True,
      3 => False,
      4 => False,
      5 => False,
      6 => False,
      7 => False);

end Servos.Config;
