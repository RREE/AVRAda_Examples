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
with AVR.UART;
with AVR.MCU;
with AVR.Real_Time.Clock;  pragma Unreferenced (AVR.Real_Time.Clock);

with DHT;                          use DHT;
with DHT.Sensors;
with DHT.Images;

procedure DHT22_Main is
   T  : DHT_Temperature;
   H  : DHT_Humidity;

   procedure Show (T : DHT_Temperature; H : DHT_Humidity) is
      use UART;
      use DHT.Images;
   begin
      Put ("T: ");
      if T = Invalid_T then Put("invalid"); else Put(Image(T)); Put("°C"); end if;
      Put (", H: ");
      if H = Invalid_H then Put("invalid"); else Put(Image(H)); Put("%"); end if;
      New_Line;
   end Show;

begin
   UART.Init (UART.Baud_19200_16MHz);
   UART.Put_Line ("starting DHT demo");

   -- provide power at pin 11
   MCU.DDRB_Bits(3) := DD_Output;
   MCU.PORTB_Bits(3) := High;

   delay 1.0; UART.Put('.');
   delay 1.0; UART.Put('.');
   delay 1.0; UART.Put('.');
   delay 1.0; UART.Put('.');

   loop
      Start_Measurement (DHT.Sensors.S1);
      delay 0.100;
      Read_Measurement (DHT.Sensors.S1);

      T := DHT.Temperature (DHT.Sensors.S1);
      H := DHT.Humidity (DHT.Sensors.S1);

      Show (T, H);

      delay 2.0;
   end loop;

end DHT22_Main;
