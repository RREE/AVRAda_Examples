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

with Ada.Unchecked_Conversion;
with Interfaces;                   use Interfaces;
with AVR.Strings;                  use AVR.Strings;
with AVR.Int_Img;                  use AVR.Int_Img;

package body DHT.Images is

   --  temperature range is -40.0 .. 125.0, humidity range is 0.0
   --  .. 100.0.  Both functions return a right adjusted textual
   --  representation with one decimal digit.

   function Image (Value : DHT_Temperature) return AStr5
   is
      function To_H is
         new Ada.Unchecked_Conversion (Source => DHT_Temperature,
                                       Target => DHT_Humidity);
   begin
      return Image(To_H(Value));
   end Image;


   function Image (Value : DHT_Humidity) return AStr5
   is
      function "+" is
         new Ada.Unchecked_Conversion (Source => DHT_Humidity,
                                       Target => Unsigned_16);
      Result : AStr5;
      Val_U16 : constant Unsigned_16 := +Value;
   begin
      U16_Img_Right (Val_U16, Result);
      for I in Unsigned_8'(2) .. 4 loop
         Result(I-1) := Result(I);
      end loop;
      Result(4) := '.';
      return Result;
   end Image;

end DHT.Images;
