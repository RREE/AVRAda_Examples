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

package DHT.Sensors is
   pragma Preelaborate;

   S1 : Sensor_T;

   type Device_T is (DHT11, DHT22, DHT21, AM2301, AM2303);

   -- atmega328p B4 = digital pin 12
   S1_Dev : constant Device_T := AM2303;
   S1_Pin : constant Bit_Number := 4;
   S1_DD  : Boolean renames MCU.DDRB_Bits (S1_Pin);
   S1_Out : Boolean renames MCU.PORTB_Bits (S1_Pin);
   S1_In  : Boolean renames MCU.PINB_Bits (S1_Pin);

   S2_Dev : constant Device_T := AM2303;
   S2_Pin : constant Bit_Number := 5;
   S2_DD  : Boolean renames MCU.DDRB_Bits (S2_Pin);
   S2_Out : Boolean renames MCU.PORTB_Bits (S2_Pin);
   S2_In  : Boolean renames MCU.PINB_Bits (S2_Pin);

end DHT.Sensors;
