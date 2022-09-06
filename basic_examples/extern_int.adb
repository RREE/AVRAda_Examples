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
with AVR.Interrupts;
with AVR.UART;
with AVR.Ext_Int;                  use AVR.Ext_Int;

package body Extern_Int is

   --  Enable_Ext_Int0 : Boolean renames MCU.EIMSK_Bits (MCU.INT0_Bit);
   --  Enable_Ext_Int1 : Boolean renames MCU.EIMSK_Bits (MCU.INT1_Bit);

   Int0_Pin : Boolean renames MCU.PORTD_Bits(2);
   Int1_Pin : Boolean renames MCU.PORTD_Bits(3);
   Int0_DD  : Boolean renames MCU.DDRD_Bits(2);
   Int1_DD  : Boolean renames MCU.DDRD_Bits(3);

   procedure Init is
   begin
      --  set the key pins to input
      Int0_DD := DD_Input;
      Int1_DD := DD_Input;
      --  enable internal pull ups
      Int0_Pin := High;
      Int1_Pin := High;

      --  Original code:
      --  configure ext int 0 and 1 to trigger at falling edges
      --  MCU.EICRA_Bits := (MCU.ISC00_Bit => Low,
      --                     MCU.ISC01_Bit => High,
      --                     MCU.ISC10_Bit => Low,
      --                     MCU.ISC11_Bit => High,
      --                     others => Low);
      --
      --  --  enable the external interrupts in the interrupt mask
      --  Enable_Ext_Int0 := True;
      --  Enable_Ext_Int1 := True;

      --  Using AVR-Ada library
      Set_Int0_Sense_Control (Falling_Edge);
      Set_Int1_Sense_Control (Falling_Edge);

      Enable_External_Interrupt_0;
      Enable_External_Interrupt_1;

      --  enable interrupts generally in the MCU
      AVR.Interrupts.Enable;
   end Init;


   procedure On_Keypress_0;
   pragma Machine_Attribute (Entity         => On_Keypress_0,
                             Attribute_Name => "signal");
   pragma Export (C, On_Keypress_0, AVR.MCU.Sig_INT0_String);

   procedure On_Keypress_0 is
   begin
      UART.Put_Line("keypress 0");
   end On_Keypress_0;


   procedure On_Keypress_1;
   pragma Machine_Attribute (Entity         => On_Keypress_1,
                             Attribute_Name => "signal");
   pragma Export (C, On_Keypress_1, AVR.MCU.Sig_INT1_String);

   procedure On_Keypress_1 is
   begin
      UART.Put_Line("keypress 1");
   end On_Keypress_1;

end Extern_Int;
