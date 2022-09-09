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

with Interfaces;                   use Interfaces;
with AVR;                          use AVR;
with AVR.UART;

package body Family is

   procedure Image (This : Parent) is
   begin
      UART.Put ("Parent (Id:");
      UART.Put (This.Id);
      UART.Put (")");
      UART.New_Line;
   end Image;


   function Create (Id : Unsigned_8) return Parent
   is
      Result : Parent;
   begin
      Result.Id := Id;
      return Result;
   end Create;


   procedure Image (This : Child) is
   begin
      UART.Put ("Child (Id:");
      UART.Put (This.Id);
      UART.Put (", Data: ");
      UART.Put (This.Data);
      UART.Put (")");
      UART.New_Line;
   end Image;


   function Create (Id : Unsigned_8) return Child
   is
      Result : Child;
   begin
      Result.Id := Id;
      Result.Data := 11;
      return Result;
   end Create;

end Family;
