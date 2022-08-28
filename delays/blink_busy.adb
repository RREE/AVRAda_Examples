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

--  get a delay by active waiting, no need for a timer or the clock

with LED;
with AVR;
with AVR.Wait;
with Avrada_Rts_Config;

procedure Blink_Busy is
   procedure Wait_1_Sec is new
     AVR.Wait.Generic_Wait_USecs (Avrada_Rts_Config.Clock_Frequency,
                                  1_000_000);
begin
   LED.Init;
   loop
      LED.Off_1;
      Wait_1_Sec;
      LED.On_1;
      Wait_1_Sec;
   end loop;
end Blink_Busy;
