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

package body LED is

   --  Compile time boolean constants serve as kind of conditional
   --  compiling.  All these routines are typically inlined and
   --  generate just a single assembler instruction.

   Has_LED1 : constant Boolean := True;
   Has_LED2 : constant Boolean := False;


   --  check your actual wiring. The STK500 connects the LEDs between
   --  the port pin and +5V. You switch them on by setting the pin to
   --  Low (stk500 --> set LEDx_On_Is_High to False).  The Arduino has
   --  a LED between B5 and ground.  You have to set the pin high to
   --  switch on.
   LED1_On_Is_High : constant Boolean := True;
   LED2_On_Is_High : constant Boolean := True;


   --  there is a LED on the Arduino platform at Port B, pin 5 (digital pin 13)
   LED1    : Boolean renames AVR.MCU.PORTB_Bits (5);
   LED1_DD : Boolean renames AVR.MCU.DDRB_Bits (5);

   LED2    : Boolean renames AVR.MCU.PORTB_Bits (6);
   LED2_DD : Boolean renames AVR.MCU.DDRB_Bits (6);


   procedure Off_1 is
   begin
      if Has_LED1 then
         if LED1_On_Is_High then
            LED1 := Low;  --  Arduino
         else
            LED1 := High; --  stk500
         end if;
      else
         null;
      end if;
   end Off_1;

   procedure Off_2 is
   begin
      if Has_LED2 then
         if LED1_On_Is_High then
            LED2 := Low;  --  Arduino
         else
            LED2 := High; --  stk500
         end if;
      else
         null;
      end if;
   end Off_2;

   procedure On_1 is
   begin
      if Has_LED1 then
         if LED1_On_Is_High then
            LED1 := High;  -- Arduino
         else
            LED1 := Low;  -- stk500
         end if;
      else
         null;
      end if;
   end On_1;

   procedure On_2 is
   begin
      if Has_LED2 then
         if LED2_On_Is_High then
            LED2 := High;  -- Arduino
         else
            LED2 := Low;  -- stk500
         end if;
      else
         null;
      end if;
   end On_2;

   procedure Init is
      --  JTD : Boolean renames MCU.MCUCR_Bits (MCU.JTD_Bit);
   begin
      -- disable JTAG on Butterfly for enabling access to port F
      -- JTD := True;
      -- MCU.MCUCR := MCU.JTD_Mask;

      if Has_LED1 then LED1_DD := DD_Output; Off_1; end if;
      if Has_LED2 then LED2_DD := DD_Output; Off_2; end if;
   end Init;

end LED;
