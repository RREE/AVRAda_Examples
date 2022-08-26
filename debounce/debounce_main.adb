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


--  This code is the Ada version of Peter Dannegger's C code as published on
--  http://www.mikrocontroller.net/forum/read-4-20549.html


--***********************************************************************
--                                                                      *
--                      Debouncing 8 Keys                               *
--                      Sampling 4 Times                                *
--                      With Repeat Function                            *
--                                                                      *
--              Author: Peter Dannegger                                 *
--                      danni@specs.de                                  *
--                                                                      *
--***********************************************************************

with Interfaces;                   use Interfaces;
with AVR;                          use AVR;
with AVR.MCU;
with AVR.Interrupts;
with AVR.Timer0;

with Debounce;                     use Debounce;

procedure Debounce_Main is

   LED0_Out : Boolean renames MCU.PORTB_Bits (0);
   LED1_Out : Boolean renames MCU.PORTB_Bits (1);
   LED_Port : Unsigned_8 renames MCU.PORTB;

   Key0 : constant Unsigned_8 := MCU.PortD0_Mask;
   Key1 : constant Unsigned_8 := MCU.PortD1_Mask;
   Key2 : constant Unsigned_8 := MCU.PortD2_Mask;

begin -- main

   -- MCU.TCCR0 := MCU.CS02_Mask;                     -- divide by 256 * 256
   -- MCU.TIMSK := MCU.TOIE0_Mask;                    -- enable timer interrupt
   Timer0.Init_Normal (Timer0.Scale_By_256);
   Timer0.Enable_Interrupt_Overflow;

   MCU.DDRB_Bits := (others => DD_Output);
   MCU.DDRD_Bits := (others => DD_Input);

   AVR.Interrupts.Enable;

   loop                                        -- main loop

      -- single press:

      if Get_Key_Press (Key0) /= 0 then        -- Key 0:
         Led0_Out := not Led0_Out;             -- toggle LED 0
      end if;

      -- single long press:

      if Get_Key_Rpt (Key1) /= 0               -- long press key 1
        and then Get_Key_Press (Key1) /= 0     -- after short press:
      then
         Led1_Out := not Led1_Out;             -- toggle LED 1
      end if;


      -- repeat on long press:

      if Get_Key_Press (Key2) /= 0             -- Key 2 or
        or else
        Get_Key_Rpt (Key2) /= 0                -- long press Key 2:
      then
         LED_Port := LED_Port + 1;             -- LEDs count up
      end if;

   end loop;

end Debounce_main;
