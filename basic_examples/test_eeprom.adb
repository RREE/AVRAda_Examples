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

--  Accessing variable stored in internal EEPROM of AVR
--
--  This example explains how global variables can be initialized at
--  compile-time and stored into the internal EEPROM. The program can
--  now refer to these variables using the symbolic name without
--  knowing the address.
--
--  The ISP-Programmer must upload both the rom-file and the
--  eeprom-file. See the Makefile target %.eep. You have to uncomment
--  the upload rule in %.prog


with Interfaces;                   use Interfaces;
with AVR;                          use AVR;
with AVR.MCU;
with AVR.EEprom;

with EEprom_Vars;                  use EEprom_Vars;


procedure Test_EEprom is

   --
   --  these variables get initialized from the EEprom values
   State1 : Nat8;
   State2 : Nat16;
   Float_Var : Float;
   F_Bytes : Nat8_Array (1 .. 4);   -- make the bytes overlay the float var
   for F_Bytes'Address use Float_Var'Address;

begin
   MCU.DDRB_Bits := (others => DD_Output);  -- use all pins on port B for output
   MCU.PORTB := 16#FF#;

   -- read variable from EEPROM addr 0002
   State1 := EEprom.Get (EEprom_Var1'Address);
   MCU.PORTB := not State1;                 -- and output value (1) to port B

   -- and write value to EEPROM addr 0003
   EEprom.Put (EEprom_Var2'Address, State1);

   -- read 16 bit variable from EEPROM
   State2 := EEprom.Get (EEprom_Var3'Address);
   -- output lower byte (3) to port B
   MCU.PORTB := not Low_Byte (State2);

   -- read float value (1.3456) from EEPROM
   EEprom.Get (EEprom_Var4'Address, F_Bytes);
   if Float_Var = 1.3456 then
      MCU.PORTB := not 1;
   end if;

   -- loop forever
   loop null; end loop;

end Test_EEprom;
