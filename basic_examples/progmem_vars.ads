with Interfaces;                   use Interfaces;

package Progmem_Vars is

   --  Constants in the program memory area must be defined at library
   --  level, i.e. not nested in a procedure.  As they are constants
   --  by definition this is not actually a restriction.
   --
   --  Attention: although they are constants, they *must not* be
   --  declared constants at the Ada level!

   --
   --  these variables reside in flash memory which makes them
   --  actually constants.
   State1 : Unsigned_8 := 16#0F#;
   pragma Linker_Section (State1, ".progmem.data");

   State2 : Unsigned_16 := 16#BEAF#;
   pragma Linker_Section (State2, ".progmem.data");

   Const_Array : array (Unsigned_8 range 3 .. 6) of Unsigned_8 :=
     (3 => 16#DE#,
      4 => 16#AD#,
      5 => 16#BE#,
      6 => 16#AF#);
   pragma Linker_Section (Const_Array, ".progmem.data");


end Progmem_Vars;
