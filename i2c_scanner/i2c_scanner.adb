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


--  simple program to scan the bus and see if it can find a device.
with System;
with Interfaces;
with AVR;                          use AVR;
with AVR.Interrupts;
with AVR.UART;                     use AVR.Uart;
with AVR.Real_Time.Clock;  pragma Unreferenced (AVR.Real_Time.Clock);
with AVR.I2C;                      use type AVR.I2C.I2C_Address;
with AVR.I2C.Master;

with I2C_Addresses;


procedure I2C_Scanner
is
   subtype Valid_I2C_Address is I2C.I2C_Address range 1 .. 16#77#;
   Found   : Boolean;
   Nothing : Boolean;
begin
   Interrupts.Enable;
   UART.Init (Baud_57600_16MHz);
   Put_Line ("I2C bus scanner");

   I2C.Master.Init;

   Endless:
   loop
      for I in 1 .. 5 loop
         delay 1.0; Put('.');
      end loop;
      New_Line;

      Nothing := True;
      Addresses:
      for Dev in Valid_I2C_Address loop
         I2C.Master.Detect_Device (Dev, Found);
         if Found then
            Nothing := False;
            Put ("I2C client at: 16#");
            Put (Interfaces.Unsigned_8(Dev), Base => 16);
            Put ("#");
            New_Line;
            Put (I2C_Addresses.Device_Name (Dev));
            New_Line;
         end if;

      end loop Addresses;
      if Nothing then
         Put ("no device found");
         New_Line;
      end if;
   end loop Endless;
end I2C_Scanner;
