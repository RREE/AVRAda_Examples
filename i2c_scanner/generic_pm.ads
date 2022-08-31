with AVR.Strings;                  use AVR.Strings;
with AVR.Strings.Progmem;          use AVR.Strings.Progmem;

generic
   Str : AVR_String;
package Generic_PM is

   Str_PM : constant Text_In_Progmem := (Str'Length, Str)
     with Linker_Section => (".progmem.data");
   PM : constant PM_String :=
     (if Str'Length>0 then PM_String(Str_PM'Address) else Nil);

end Generic_PM;
