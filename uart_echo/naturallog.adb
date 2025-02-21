package body naturalLog is

    -- taylor series natural log function
   function ln(X : Float) return Float is
      Y  : Float;
      Y2 : Float;
      Result : Float := 0.0;
      Term   : Float;
      N      : Integer := 1;
   begin
      if X <= 0.0 then
         return 0.0;
      end if;

      Y := (X - 1.0) / (X + 1.0);
      Y2 := Y * Y;
      Term := Y;

      while Term / Float(N) > 1.0E-10 loop
         Result := Result + Term / Float(N);
         Term := Term * Y2;
         N := N + 2;
      end loop;

      return 2.0 * Result;
   end ln;

end naturalLog;
