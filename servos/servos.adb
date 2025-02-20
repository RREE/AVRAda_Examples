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
with Servos.Config;                use Servos.Config;
with Servos.Timer;
with AVRAda_RTS_Config;

package body Servos is

   --  Set the pin of the first servo to high. Set the reset time in
   --  the timer overflow.  When the first delay expires, set the
   --  corrspondig pin to low and activate the next servo.  Continue
   --  for all configured servos. At the end wait for 8ms, then
   --  restart.

   --  The minimum cycle time (repetition rate) is for only one servo
   --  at the left most position 1ms + 8ms = 9ms. The maximum cycle
   --  time is for 8 servos at the right most position 8 * 2ms + 8ms =
   --  24ms.

   --  Prescaling of the timer, i.e. the timer ticks don't run at 16MHz
   --  but at 16MHz/Prescale.
   Prescale   : constant := 128;

   --  cycle time is 20 ms = 0.02 s
   --  Cycle_Ticks : constant := 20 * Clock_Frequency / Prescale / 1000;  -- = 40,000 ticks

   --  all named numbers are time spans in micro seconds, i.e. 10-6 s.
   Mid_Pos_Delay   : constant := 1500;
   -- Left_Pos_Delay  : constant := 1000;  --   800
   -- Right_Pos_Delay : constant := 2000;  --  2200

   --  Number of µC-steps for a certain time:
   --  Time  * Freq  = Steps
   --  2.0ms * 16MHz = 32000
   --  1.5ms * 16MHz = 24000
   --  1.0ms * 16MHz = 16000

   --  (orig. Freq) 16Mhz / (prescale) 8 = 2MHz
   --  Time  * Freq  = Steps
   --  2.0ms *  2MHz =  4000
   --  1.5ms *  2MHz =  3000
   --  1.0ms *  2MHz =  2000

   --  (orig. Freq) 16Mhz / (prescale) 64 = 250kHz
   --  Time  * Freq  = Steps
   --  2.0ms *  250kHz = 500
   --  1.5ms *  250kHz = 375
   --  1.0ms *  250kHz = 250

   --  (orig. Freq) 16Mhz / (prescale) 128 = 125kHz
   --  Time  * Freq  = Steps
   --  2.0ms *  125kHz = 250
   --  1.5ms *  125kHz = 187
   --  1.0ms *  125kHz = 125

   Wait_2ms : constant Unsigned_8 := 250;
   
   
   function Timer_Steps_For_Pos (P : Position) return Unsigned_8
   is
      Clock_Frequency : constant := Avrada_Rts_Config.Clock_Frequency;
      --  delay time per position
      --  Alpha : constant := Max_Delay_Diff / 2 / Full_Right_Position;  --  5
      --  timer steps per position
      --  A     : constant := Alpha * Clock_Frequency / 1_000_000 / Prescale; -- 5/8
      --  timer steps to wait for the mid position (1.5ms)
      Mid   : constant := Mid_Pos_Delay * Clock_Frequency / 1_000_000 / Prescale; -- 187,5
   begin
      return Unsigned_8(Integer_16(P) * 5 / 8 + Mid);
   end Timer_Steps_For_Pos;

   Max_Steps  : constant := 12;
   type Step_Count is mod Max_Steps;

   Step : Step_Count;
   --  steps 0..7 are the servos, steps 8..11 are wait cycles
   --  count 4 x 2ms at the end of each cycling over all servos


   procedure Timer_Action;
   pragma Machine_Attribute (Entity         => Timer_Action,
                             Attribute_Name => "signal");
   pragma Export (C, Timer_Action, Timer.Signal_Compare);


   --  The timer expired, we are at the end of a wait cycle. The pin
   --  of the current servo must go low, the pin of the next servo
   --  must be set high.
   --
   --  We wait 4 x 2ms between servo 7 and servo 0. When the control
   --  pin of servo 7 is set low, we start the wait count. When the
   --  wait count (4x2ms) is over we set servo 0 high.
   --
   procedure Timer_Action
   is
   begin
      -- D := True;

      if Step < Max_Servos and then Servo_Is_Connected (Servo_Range (Step))
      then
         Servo_Port (Bit_Number(Servo_Range(Step))) := Low;
      end if;

      Step := Step + 1; -- modular, overflows at 11 --> 0

      if Step > 7 then
         -- count 4 x 2ms at the end of each cycling ober all servos
         Timer.Set_Overflow_At (Wait_2ms);

      elsif Servo_Is_Connected (Servo_Range (Step)) then
         --  set pulse
         Servo_Port (Bit_Number(Servo_Range(Step))) := High;
         Timer.Set_Overflow_At
           (Timer_Steps_For_Pos (Servo_Position (Servo_Range(Step))));
      end if;
   end Timer_Action;


   procedure Init is
   begin
      --  set the pins as Output
      Servo_DDR := Servo_DDR or Bits_In_Byte(Servo_Is_Connected);
      --  initialze pins to low value
      Servo_Port := Servo_Port and (not Bits_In_Byte(Servo_Is_Connected));

      Step := 0;

      Servo_Position := (others => Mid_Position);

      Timer.Init_CTC (Timer.Scale_By_128, Wait_2ms);
   end Init;

end Servos;
