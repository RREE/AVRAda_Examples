--  Title:    Accessing variable stored in flash program memory of AVR
--  Author:   Rolf Ebert <rolf.ebert.gcc@gmx.de>
--  Date:     30-Aug-2008

--  This example explains how global constants can be read from
--  program memory.
--

with Interfaces;                   use type Interfaces.Unsigned_8;
with AVR;                          use AVR;
with AVR.MCU;
with AVR.Programspace;
with AVR.UART;                     use AVR.UART;

with Progmem_Vars;                 use Progmem_Vars;

procedure Progmem_Main is

   State2_Var : Nat16;
   Element    : Nat8;

begin

   UART.Init (Baud_57600_16MHz);
   Put_Line ("Read vars from program memory (aka flash)");


   loop
      -- read variable from flash and output inverted value to port B
      Put ("Read State1 (8bit wide): ");
      Element := Programspace.Get (State1'Address);
      Put (Element, 16);
      New_Line;

      Put ("Read State2 (16bit wide): ");
      State2_Var := Programspace.Get (State2'Address);
      Put (State2_Var, 16);
      New_Line;

      Put ("Read array: ");
      for I in Const_Array'Range loop
         Element := Programspace.Get (Const_Array (I)'Address);
         Put (Element, 16); Put (' ');
      end loop;
      New_Line;

   end loop;

end Progmem_Main;
