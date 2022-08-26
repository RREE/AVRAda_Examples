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

package DHT is
   pragma Preelaborate;

   --  actual sensors are declared and configured in dht-wiring.ads.
   type Sensor_T is limited private;
   pragma Preelaborable_Initialization (Sensor_T);


   type DHT_Temperature is delta 0.1 digits 4 range -40.0 .. 125.1;
   for DHT_Temperature'Size use 16;

   Invalid_T : constant DHT_Temperature;


   type DHT_Humidity is delta 0.1 digits 4 range 0.0 .. 100.1;
   for DHT_Humidity'Size use 16;

   Invalid_H : constant DHT_Humidity;


   --  reading a sensor takes place in two steps: (1)Start_Measurement
   --  and (2)Read_Measurement.  There must be a delay of at least
   --  250ms between the two steps, cf. the data sheet.
   procedure Start_Measurement (Sensor : Sensor_T);
   procedure Read_Measurement (Sensor : in out Sensor_T);

   -- extract the read values
   function Temperature (Sensor : Sensor_T) return DHT_Temperature;
   function Humidity (Sensor : Sensor_T) return DHT_Humidity;


private

   type Sensor_T is record
      T     : DHT_Temperature;
      H     : DHT_Humidity;
   end record;

   pragma Inline (Temperature);
   pragma Inline (Humidity);


   Invalid_T : constant DHT_Temperature := DHT_Temperature'Last;
   Invalid_H : constant DHT_Humidity    := DHT_Humidity'Last;

end DHT;
