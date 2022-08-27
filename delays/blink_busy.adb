with LED;
with AVR;
with AVR.Wait;

procedure Blink_Busy is
   procedure Wait_1_Sec is new
     AVR.Wait.Generic_Wait_USecs (16_000_000, 1_000_000);
begin
   LED.Init;
   loop
      LED.Off_1;
      Wait_1_Sec;
      LED.On_1;
      Wait_1_Sec;
   end loop;
end Blink_Busy;
