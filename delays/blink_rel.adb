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

--
--  use standard Ada relative delays for blinking.
--
--  depending on the configuration settings in the AVR support library
--  that either uses AVR.Real_Time or busy waits from AVR.Wait;
with AVR.Real_Time.Clock;
pragma Unreferenced (AVR.Real_Time.Clock);
--  we have to explicitely import this function as it gets called via
--  the delay statement. The avr-gnatbind does not yet know that the
--  Ada.Calendar.Delay-routines call Clock and that it must be
--  included in the elaboration code. All of the timer and clock
--  infrastructure gets initialized by elaborating the body of
--  AVR.Real_Time.Clock_Impl.
--
--  AVR.Real_Time.Clock uses AVRAda_Config.Clock_Frequency (for the
--  quartz frequency) and AVR.Timer0 to generate interrupts at 1000Hz,
--  ie. every 1ms.  The delay routine continuously compares the
--  current time with the end of the delay time for returning. To save
--  power the mcu is put into sleep mode after every tick.

with LED;

procedure Blink_Rel is

   Off_Cycle : constant := 1.0;
   On_Cycle  : constant := 1.0;

begin
   LED.Init;

   loop
      LED.Off_1;
      delay Off_Cycle;
      LED.On_1;
      delay On_Cycle;
   end loop;

end Blink_Rel;
