with Interfaces;                  use Interfaces;

package EEprom_Vars is

   --
   --  the global variables are stored in EEPROM
   --
   Dummy       : Unsigned_16 := 0;       -- avoid using lowest addresses
   pragma Linker_Section (Dummy, ".eeprom");
   EEprom_Var1 : Unsigned_8 := 1;       -- EEPROM address 0002
   pragma Linker_Section (EEprom_Var1, ".eeprom");
   EEprom_Var2 : Unsigned_8 := 2;       -- EEPROM address 0003
   pragma Linker_Section (EEprom_Var2, ".eeprom");
   EEprom_Var3 : Unsigned_16    := 16#0403#; -- low byte = 0003, high = 0004
   pragma Linker_Section (EEprom_Var3, ".eeprom");
   EEprom_Var4 : Float          := 1.3456;  -- four byte float
   pragma Linker_Section (EEprom_Var4, ".eeprom");


end EEprom_Vars;
