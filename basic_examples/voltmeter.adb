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

with Interfaces;                   use Interfaces;
with AVR;                          use AVR;
with AVR.MCU;
with AVR.UART;
with AVR.ADC;
with AVR.Real_Time.Clock;
pragma Unreferenced (AVR.Real_Time.Clock);

procedure Voltmeter is
   Raw : ADC.Conversion_10bit;
   Result : Unsigned_16;
begin

   UART.Init(UART.Baud_19200_16MHz);

   MCU.DDRC_Bits(0) := DD_Input;
   MCU.PORTC_Bits(0) := Low;

   ADC.Init (ADC.Scale_By_128, ADC.Is_Vcc);

   loop
      Raw := ADC.Convert_10bit (Ch => 0);
      Result := Raw / 8;
      UART.Put (Result);
      UART.New_Line;

      delay 0.10;
   end loop;

end Voltmeter;
