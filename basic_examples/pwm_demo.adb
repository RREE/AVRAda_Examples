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


--   This example shows how to generate voltages between VCC and GND using
--   Pulse Width Modulation (PWM).

--   A LED with a series resistor should be connected from PD5 to GND.

--   See also Atmel AVR Application Note AVR130


with AVR;                          use AVR;
with AVR.MCU;
with AVR.Wait;
with AVR.Timer1;

procedure PWM_Demo is

   --  at 4MHz waiting for 4 cycles is 1 micro-second
   procedure Wait_10ms;
   pragma Inline (Wait_10ms);

   procedure Wait_10ms is
   begin
      AVR.Wait.Wait_4_Cycles (10_000);
   end Wait_10ms;

   OC1A_Pin  : constant Bit_Number := MCU.PORTD5_Bit;
   OC1A_DDR  : Bits_In_Byte renames MCU.DDRD_Bits;
   OC1A_Port : Bits_In_Byte renames MCU.PORTD_Bits;

begin
   MCU.DDRB_Bits := (others => DD_Output);  -- use all pins on PortB for output
   MCU.PORTB := 16#FF#;                 -- set output high -> turn all LEDs off


   OC1A_DDR (OC1A_Pin) := DD_Output; -- set pin5 as output
   OC1A_Port (OC1A_Pin) := False;    -- clear pin5

   -- enable 8 bit PWM, select inverted PWM
   Timer1.Init_PWM (Timer1.Scale_By_8, Timer1.Fast_PWM_8bit, Inverted => True);

   --  timer1 running on 1/8 MCU clock with clear timer/counter1 on
   --  Compare Match -- PWM frequency will be MCU clock / 8 / 512,
   --  e.g. with 4Mhz Crystal 977 Hz.


   --
   --  Dimm LED on and off in interval of 2.5 seconds
   --

   loop
      -- dimm LED off
      for I in reverse Nat8 loop
         MCU.OCR1AL := I;
         Wait_10ms;
      end loop;

      -- dimm LED on
      for I in Nat8 loop
         MCU.OCR1AL := I;
         Wait_10ms;
      end loop;
   end loop;
end PWM_Demo;
