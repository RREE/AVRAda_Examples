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
with AVR.MCU;                      use AVR.MCU;
with AVR.Interrupts;
with AVR.Timer0;

package body Debounce is


   Key_State : Unsigned_8;             -- debounced and inverted key state:
                                           -- bit = 1: key pressed
   Key_Press : Unsigned_8;                 -- key press detect

   Key_Rpt   : Unsigned_8;                 -- key long press and repeat


   procedure On_Overflow;
   pragma Machine_Attribute (Entity         => On_Overflow,
                             Attribute_Name => "signal");
   pragma Export (C, On_Overflow, Timer0.Signal_Overflow);

   Ct0, Ct1, Rpt : Unsigned_8;

   procedure On_Overflow                       -- every 4ms at 16MHz
   is
      I : Unsigned_8;
   begin
      I := Key_State xor (not Key_Input);      -- key changed ?
      Ct0 := not (Ct0 and I);                  -- reset or count ct0
      Ct1 := Ct0 xor (Ct1 and I);              -- reset or count ct1
      I := I and (Ct0 and Ct1);                -- count until roll over ?
      Key_State := Key_State xor I;            -- then toggle debounced state
      Key_Press := Key_Press or (Key_State and I);  -- 0->1: key press detect

      if (Key_State and Repeat_Mask) = 0 then  -- check repeat function
         Rpt := Repeat_Start;                  -- start delay
      end if;

      Rpt := Rpt - 1;
      if Rpt = 0 then
         Rpt := Repeat_Next;                   -- repeat delay
         Key_Rpt := Key_Rpt or (Key_State and Repeat_Mask);
      end if;
   end On_Overflow;


   function Get_Key_Press (Key_Mask : Unsigned_8) return Unsigned_8
   is
      Mask : Unsigned_8 := Key_Mask;
   begin
      Interrupts.Disable;
      Mask := Mask and Key_Press;              -- read key(s)
      Key_Press := Key_Press xor Mask;         -- clear key(s)
      Interrupts.Enable;
      return Mask;
   end Get_Key_Press;


   function Get_Key_Rpt (Key_Mask : Unsigned_8) return Unsigned_8
   is
      Mask : Unsigned_8 := Key_Mask;
   begin
      Interrupts.Disable;
      Mask := Mask and Key_Rpt;                -- read key(s)
      Key_Rpt := Key_Rpt xor Key_Mask;         -- clear key(s)
      Interrupts.Enable;
      return Mask;
   end Get_Key_Rpt;

end Debounce;
