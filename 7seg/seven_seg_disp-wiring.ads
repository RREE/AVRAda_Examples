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

package Seven_Seg_Disp.Wiring is


   Seg_A   : Boolean renames MCU.PORTB_Bits (1);--
   Seg_B   : Boolean renames MCU.PORTD_Bits (7);--
   Seg_C   : Boolean renames MCU.PORTD_Bits (5);--
   Seg_D   : Boolean renames MCU.PORTD_Bits (3);--
   Seg_E   : Boolean renames MCU.PORTD_Bits (2);--
   Seg_F   : Boolean renames MCU.PORTB_Bits (0);--
   Seg_G   : Boolean renames MCU.PORTD_Bits (6);
   Seg_Dot : Boolean renames MCU.PORTD_Bits (4);--

   Seg_A_DD   : Boolean renames MCU.DDRB_Bits (1);--
   Seg_B_DD   : Boolean renames MCU.DDRD_Bits (7);--
   Seg_C_DD   : Boolean renames MCU.DDRD_Bits (5);--
   Seg_D_DD   : Boolean renames MCU.DDRD_Bits (3);--
   Seg_E_DD   : Boolean renames MCU.DDRD_Bits (2);--
   Seg_F_DD   : Boolean renames MCU.DDRB_Bits (0);--
   Seg_G_DD   : Boolean renames MCU.DDRD_Bits (6);
   Seg_Dot_DD : Boolean renames MCU.DDRD_Bits (4);--


   Dig_1 : Boolean renames MCU.PORTC_Bits (3);
   Dig_2 : Boolean renames MCU.PORTC_Bits (2);
   Dig_3 : Boolean renames MCU.PORTC_Bits (1);
   Dig_4 : Boolean renames MCU.PORTC_Bits (0);

   Dig_1_DD : Boolean renames MCU.DDRC_Bits (3);
   Dig_2_DD : Boolean renames MCU.DDRC_Bits (2);
   Dig_3_DD : Boolean renames MCU.DDRC_Bits (1);
   Dig_4_DD : Boolean renames MCU.DDRC_Bits (0);

end Seven_Seg_Disp.Wiring;
