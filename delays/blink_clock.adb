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

--  The standard Ada 'delay until' does not work without an unpatched
--  compiler.  Here is a work-around.

with AVR;                          use AVR;
with AVR.Real_Time;                use AVR.Real_Time;
with AVR.Real_Time.Clock;
with LED;

procedure Blink_Clock is

   Next_Off : Time := Clock + 0.5;
   Next_On  : Time := Next_Off + 0.5;

begin

   LED.Init;

   loop
      if Clock > Next_Off then
         LED.Off_1;
         Next_Off := Next_Off + 1.0;
      end if;
      if Clock > Next_On then
         LED.On_1;
         Next_On := Next_On + 1.0;
      end if;
      delay 0.001; --  sleep for a millisecond
   end loop;

end Blink_Clock;
