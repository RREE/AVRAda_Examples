with AVR.I2C;
with AVR.Strings.Progmem;          use AVR.Strings.Progmem;

package I2C_Addresses is
   --  pragma Preelaborate;
   --  i2c_addresses.ads:478:17: non-static constant in preelaborated unit
   use AVR;
   use AVR.Strings;

   LF : constant Character := Character'Val (16#0A#);

   --
   --  List of known I2C devices and their typical addresses
   --
   --  The list contains information derived from
   --  https://learn.adafruit.com/i2c-addresses/the-list adopted to be
   --  printed in AVR-Ada programs. The above page was visited on
   --  2019-10-09.
   --  I added the PCF8574 GPIO expander to the list

   Dev_0E : constant Text_In_Progmem :=
     (34, "MAG3110 3-axis magnetometer (0x0E)")
     with Linker_Section => ".progmem.data.14";
   Dev_10 : constant Text_In_Progmem :=
     (62, "VEML6075 UV sensor (0x10)" & Lf &
          "VEML7700 ambient light sensor (0x10)")
     with Linker_Section => ".progmem.data.16";
   Dev_11 : constant Text_In_Progmem :=
     (42, "Si4713 FM transmitter with RDS (0x11 0x63)")
     with Linker_Section => ".progmem.data.17";
   Dev_13 : constant Text_In_Progmem :=
     (30, "VCNL40 proximity sensor (0x13)")
     with Linker_Section => ".progmem.data.19";
   Dev_18 : constant Text_In_Progmem :=
     (159, "MCP9808 temp sensor (0x18 - 0x1F)" & Lf &
           "LIS3DH 3-axis accelerometer (0x18 0x19)" & Lf &
           "LSM303 accelerometer & magnetometer (0x19 for accelerometer and0x1E for magnetometer)")
     with Linker_Section => ".progmem.data.24";
   Dev_19 : constant Text_In_Progmem :=
     (74, "MCP9808 temp sensor (0x18# - 0x1F)" & Lf &
          "LIS3DH 3-axis accelerometer (0x18 0x19)")
     with Linker_Section => ".progmem.data.25";
   Dev_1A : constant Text_In_Progmem :=
     (33, "MCP9808 temp sensor (0x18 - 0x1F)")
     with Linker_Section => ".progmem.data.26";
   Dev_1C : constant Text_In_Progmem :=
     (120, "MCP9808 temp sensor (0x18 - 0x1F)" & Lf &
          "MMA845x 3-axis accel (0x1C 0x1D)" & Lf &
          "FXOS8700 accel/mag (0x1C - 0x1F)" & Lf &
          "MMA7455L (0x1C 0x1D)")
     with Linker_Section => ".progmem.data.28";
   Dev_1D : constant Text_In_Progmem :=
     (218, "MCP9808 temp sensor (0x18 - 0x1F)" & Lf &
          "MMA845x 3-axis accel (0x1C 0x1D)" & Lf &
          "FXOS8700 accel/mag (0x1C - 0x1F)" & Lf &
          "LSM9DS0 9-axis IMU (0x1D 0x1E for accel/mag, 0x6A 0x6B for gyro)" & Lf &
          "ADXL345 3-axis accel (0x1D 0x53)" & Lf &
          "MMA7455L (0x1C 0x1D)")
     with Linker_Section => ".progmem.data.29";
   Dev_1E : constant Text_In_Progmem :=
     (212, "MCP9808 temp sensor (0x18 - 0x1F)" & Lf &
          "FXOS8700 accel/mag (0x1C - 0x1F)" & Lf &
          "LSM303 accel & mag (0x19 for accel and 0x1E for mag)" & Lf &
          "LSM9DS0 9-axis IMU (0x1D 0x1E for accel/mag, 0x6A 0x6B for gyro)" & Lf &
          "HMC5883 magnetometer (0x1E)")
     with Linker_Section => ".progmem.data.30";
   Dev_1F : constant Text_In_Progmem :=
     (66, "MCP9808 temp sensor (0x18 - 0x1F)" & Lf &
          "FXOS8700 accel/mag (0x1C - 0x1F)")
     with Linker_Section => ".progmem.data.31";
   Dev_20 : constant Text_In_Progmem :=
     (168, "FXAS21002 gyroscope (0x20 0x21)" & Lf &
          "Chirp! Water sensor (0x20)" & Lf &
          "MCP23008 GPIO expander (0x20 - 0x27)" & Lf &
          "MCP23017 GPIO expander (0x20 - 0x27)" & Lf &
          "PCF8574 GPIO expander (0x20 - 0x27)")
     with Linker_Section => ".progmem.data.32";
   Dev_21 : constant Text_In_Progmem :=
     (141, "FXAS21002 Gyroscope (0x20 0x21)" & Lf &
          "MCP23008 GPIO expander (0x20 - 0x27)" & Lf &
          "MCP23017 GPIO expander (0x20 - 0x27)" & Lf &
          "PCF8574 GPIO expander (0x20 - 0x27)")
     with Linker_Section => ".progmem.data.33";
   Dev_22 : constant Text_In_Progmem :=
     (109, "MCP23008 GPIO expander (0x20 - 0x27)" & Lf &
          "MCP23017 GPIO expander (0x20 - 0x27)" & Lf &
          "PCF8574 GPIO expander (0x20 - 0x27)")
     with Linker_Section => ".progmem.data.34";
   Dev_26 : constant Text_In_Progmem :=
     (141, "MCP23008 GPIO expander (0x20 - 0x27)" & Lf &
          "MCP23017 GPIO expander (0x20 - 0x27)" & Lf &
          "PCF8574 GPIO expander (0x20 - 0x27)" & Lf &
          "MSA301 triple axis accel (0x26)")
     with Linker_Section => ".progmem.data.38";
   Dev_28 : constant Text_In_Progmem :=
     (104, "BNO055 IMU (0x28 0x29)" & Lf &
          "CAP1188 8-channel capacitive touch (0x28 - 0x2D)" & Lf &
          "TSL2591 light sensor (0x29 0x28)")
     with Linker_Section => ".progmem.data.40";
   Dev_29 : constant Text_In_Progmem :=
     (205, "BNO055 IMU (0x28 0x29)" & Lf &
          "TCS34725 color sensor (0x29)" & Lf &
          "TSL2561/TSL2591 light sensor (0x28 0x29 0x39 0x49)" & Lf &
          "VL53L0x ToF distance (0x29)" & Lf &
          "VL6180X ToF sensor (0x29)" & Lf &
          "CAP1188 8-channel capacitive touch (0x28 - 0x2D)")
     with Linker_Section => ".progmem.data.41";
   Dev_2A : constant Text_In_Progmem :=
     (48, "CAP1188 8-channel capacitive touch (0x28 - 0x2D)")
     with Linker_Section => ".progmem.data.42";
   Dev_38 : constant Text_In_Progmem :=
     (67, "VEML6070 UV Index (0x38 0x39)" & Lf &
          "FT6x06 capacitive touch driver (0x38)")
     with Linker_Section => ".progmem.data.56";
   Dev_39 : constant Text_In_Progmem :=
     (110, "TSL2561 light sensor (0x29 0x39 0x49)" & Lf &
          "VEML6070 UV Index (0x38 0x39)" & Lf &
          "APDS-9960 IR/color/proximity sensor (0x39)")
     with Linker_Section => ".progmem.data.57";
   Dev_3C : constant Text_In_Progmem :=
     (43, "SSD1305/SSD1306 monochrome OLED (0x3C 0x3D)")
     with Linker_Section => ".progmem.data.60";
   Dev_40 : constant Text_In_Progmem :=
     (237, "Si7021/HTU21D-F/HDC1008 humidity/temp sensor (0x40 - 0x43)" & Lf &
          "TMP007/TMP006 IR temp sensor (0x40 - 0x47)" & Lf &
          "PCA9685 16-channel PWM driver (0x40 - 0x7F)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.64";
   Dev_41 : constant Text_In_Progmem :=
     (234, "HDC1008 humidity/temp sensor (0x40 - 0x43)" & Lf &
          "TMP007/TMP006 IR temp sensor (0x40 - 0x47)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)" & Lf &
          "STMPE610/STMPE811 resistive touch controller (0x41 0x44)")
     with Linker_Section => ".progmem.data.65";
   Dev_42 : constant Text_In_Progmem :=
     (177, "HDC1008 humidity/temp sensor (0x40 - 0x43)" & Lf &
          "TMP007/TMP006 IR temp sensor (0x40 - 0x47)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.66";
   Dev_44 : constant Text_In_Progmem :=
     (229, "SHT31 humidity/temp sensor (0x44 - 0x45)" & Lf &
          "TMP006/TMP007 IR temp sensor (0x40 - 0x47)" & Lf &
          "ISL29125 color sensor (0x44)" & Lf &
          "INA219/INA260 DC current/voltage/power sensor (0x40 - 0x4F)" & Lf &
          "STMPE610/STMPE811 resistive touch controller (0x41 0x44)")
     with Linker_Section => ".progmem.data.68";
   Dev_46 : constant Text_In_Progmem :=
     (134, "TMP006/TMP007 IR temp sensor (0x40 - 0x47)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.70";
   Dev_48 : constant Text_In_Progmem :=
     (196, "TMP102 temp sensor (0x48 - 0x4B)" & Lf &
          "PN532 NFC/RFID reader (0x48)" & Lf &
          "ADS1115 4-channel 16-bit ADC (0x48 - 0x4B)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.72";
   Dev_49 : constant Text_In_Progmem :=
     (205, "TSL2561 light sensor (0x29 0x39 0x49)" & Lf &
          "TMP102 temp sensor (0x48 - 0x4B)" & Lf &
          "ADS1115 4-channel 16-bit ADC (0x48 - 0x4B)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.73";
   Dev_4A : constant Text_In_Progmem :=
     (167, "TMP102 temp sensor (0x48 - 0x4B)" & Lf &
          "ADS1115 4-channel 16-bit ADC (0x48 - 0x4B)" & Lf &
          "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.74";
   Dev_4C : constant Text_In_Progmem :=
     (91, "INA219 DC current/voltage sensor (0x40 - 0x4F)" & Lf &
          "INA260 DC current/power sensor (0x40 - 0x4F)")
     with Linker_Section => ".progmem.data.76";
   Dev_50 : constant Text_In_Progmem :=
     (29, "MB85RC I2C FRAM (0x50 - 0x57)")
     with Linker_Section => ".progmem.data.80";
   Dev_52 : constant Text_In_Progmem :=
     (65, "MB85RC I2C FRAM (0x50 - 0x57)" & Lf &
          "Nintendo Nunchuck controller (0x52)")
     with Linker_Section => ".progmem.data.82";
   Dev_53 : constant Text_In_Progmem :=
     (70, "ADXL345 3-axis accelerometer (0x1D 0x53)" & Lf &
          "MB85RC I2C FRAM (0x50 - 0x57)")
     with Linker_Section => ".progmem.data.83";
   Dev_57 : constant Text_In_Progmem :=
     (69, "MB85RC I2C FRAM (0x50 - 0x57)" & Lf &
          "MAX3010x pulse & Oximetry sensor (0x57)")
     with Linker_Section => ".progmem.data.87";
   Dev_58 : constant Text_In_Progmem :=
     (63, "TPA2016 I2C-controlled amplifier (0x58)" & Lf &
          "SGP30 gas sensor (0x58)")
     with Linker_Section => ".progmem.data.88";
   Dev_5A : constant Text_In_Progmem :=
     (149, "MPR121 12-point capacitive touch sensor (0x5A - 0x5D)" & Lf &
          "CCS811 VOC sensor (0x5A 0x5B)" & Lf &
          "MLX9061x IR temp sensor (0x5A)" & Lf &
          "DRV2605 haptic motor driver (0x5A)")
     with Linker_Section => ".progmem.data.90";
   Dev_5B : constant Text_In_Progmem :=
     (83, "MPR121 12-point capacitive touch sensor (0x5A - 0x5D)" & Lf &
          "CCS811 VOC sensor (0x5A 0x5B)")
     with Linker_Section => ".progmem.data.91";
   Dev_5C : constant Text_In_Progmem :=
     (88, "AM2315 humidity/temp sensor (0x5C)" & Lf &
          "MPR121 12-point capacitive touch sensor (0x5A - 0x5D)")
     with Linker_Section => ".progmem.data.92";
   Dev_5D : constant Text_In_Progmem :=
     (53, "MPR121 12-point capacitive touch sensor (0x5A - 0x5D)")
     with Linker_Section => ".progmem.data.93";
   Dev_60 : constant Text_In_Progmem :=
     (225, "MPL115A2/MPL3115A2 barometric pressure (0x60)" & Lf &
          "Si5351A clock generator (0x60 0x61)" & Lf &
          "Si1145 light/IR sensor (0x60)" & Lf &
          "MCP4725A0 12-bit DAC (0x60 0x61)" & Lf &
          "TEA5767 radio receiver (0x60)" & Lf &
          "VCNL4040 proximity and ambient light sensor (0x60)")
     with Linker_Section => ".progmem.data.96";
   Dev_61 : constant Text_In_Progmem :=
     (68, "Si5351A clock generator (0x60 0x61)" & Lf &
          "MCP4725A0 12-bit DAC (0x60 0x61)")
     with Linker_Section => ".progmem.data.97";
   Dev_62 : constant Text_In_Progmem :=
     (32, "MCP4725A1 12-bit DAC (0x62 0x63)")
     with Linker_Section => ".progmem.data.98";
   Dev_63 : constant Text_In_Progmem :=
     (75, "MCP4725A1 12-bit DAC (0x62 0x63)" & Lf &
          "Si4713 FM transmitter with RDS (0x11 0x63)")
     with Linker_Section => ".progmem.data.99";
   Dev_64 : constant Text_In_Progmem :=
     (32, "MCP4725A2 12-bit DAC (0x64 0x65)")
     with Linker_Section => ".progmem.data.100";
   Dev_66 : constant Text_In_Progmem :=
     (32, "MCP4725A3 12-bit DAC (0x66 0x67)")
     with Linker_Section => ".progmem.data.102";
   Dev_68 : constant Text_In_Progmem :=
     (167, "AMG8833 IR thermal camera breakout (0x68 0x69)" & Lf &
          "DS1307/PCF8523/DS3231 RTC (0x68)" & Lf &
          "MPU-9250 9-DoF IMU (0x68 0x69)" & Lf &
          "MPU-60X0 accel+gyro (0x68 0x69)" & Lf &
          "ITG3200 gyro (0x68 0x69)")
     with Linker_Section => ".progmem.data.104";
   Dev_69 : constant Text_In_Progmem :=
     (124, "AMG8833 IR thermal camera breakout (0x68 0x69)" & Lf &
          "MPU-9250 (0x68 0x69)" & Lf &
          "MPU-60X0 accel+gyro (0x68 0x69)" & Lf &
          "ITG3200 gyro (0x68 0x69)")
     with Linker_Section => ".progmem.data.105";
   Dev_6A : constant Text_In_Progmem :=
     (94, "L3GD20H gyroscope (0x6A 0x6B)" & Lf &
          "LSM9DS0 9-axis IMU (0x1D 0x1E for accel/mag, 0x6A 0x6B for gyro)")
     with Linker_Section => ".progmem.data.106";
   Dev_70 : constant Text_In_Progmem :=
     (84, "TCA9548 1-to-8 I2C multiplexer (0x70 - 0x77)" & Lf &
          "HT16K33 LED matrix driver (0x70 - 0x77)")
     with Linker_Section => ".progmem.data.112";
   Dev_74 : constant Text_In_Progmem :=
     (132, "IS31FL3731 144-LED CharliePlex driver (0x74 - 0x77)" & Lf &
          "TCA9548 1-to-8 multiplexer (0x70 - 0x77)" & Lf &
          "HT16K33 LED matrix driver (0x70 - 0x77)")
     with Linker_Section => ".progmem.data.116";
   Dev_76 : constant Text_In_Progmem :=
     (240, "BME280/BMP280 temp / barometric / BME280 humidity (0x76 0x77)" & Lf &
          "IS31FL3731 144-LED CharliePlex driver (0x74 - 0x77)" & Lf &
          "TCA9548 1-to-8 multiplexer (0x70 - 0x77)" & Lf &
          "HT16K33 LED matrix driver (0x70 - 0x77)" & Lf &
          "MS5607/MS5611 barometric pressure (0x76 0x77)")
     with Linker_Section => ".progmem.data.118";
   Dev_77 : constant Text_In_Progmem :=
     (249, "BME280/BMP280/BMP085/BMP180 temp/barometric / BME280 humidity (0x76 0x77)" & Lf &
          "TCA9548 1-to-8 multiplexer (0x70 - 0x77)" & Lf &
          "IS31FL3731 144-LED CharliePlex (0x74 - 0x77)" & Lf &
          "HT16K33 LED matrix (0x70 - 0x77)" & Lf &
          "BMA180 accel (0x77)" & Lf &
          "MS5607/MS5611 barometric (0x76 0x77)")
     with Linker_Section => ".progmem.data.119";


   Device_Name : constant array (I2C.I2C_Address) of PM_String :=
     (
      16#0E# => PM_String (Dev_0E'Address),
      16#10# => PM_String (Dev_10'Address),
      16#11# => PM_String (Dev_11'Address),
      16#13# => PM_String (Dev_13'Address),
      16#18# => PM_String (Dev_18'Address),
      16#19# => PM_String (Dev_19'Address),
      16#1A# => PM_String (Dev_1A'Address),
      16#1C# => PM_String (Dev_1C'Address),
      16#1D# => PM_String (Dev_1D'Address),
      16#1E# => PM_String (Dev_1E'Address),
      16#1F# => PM_String (Dev_1F'Address),
      16#20# => PM_String (Dev_20'Address),
      16#21# => PM_String (Dev_21'Address),
      16#22# => PM_String (Dev_22'Address),
      16#26# => PM_String (Dev_26'Address),
      16#28# => PM_String (Dev_28'Address),
      16#29# => PM_String (Dev_29'Address),
      16#2A# => PM_String (Dev_2A'Address),
      16#38# => PM_String (Dev_38'Address),
      16#39# => PM_String (Dev_39'Address),
      16#3C# => PM_String (Dev_3C'Address),
      16#40# => PM_String (Dev_40'Address),
      16#41# => PM_String (Dev_41'Address),
      16#42# => PM_String (Dev_42'Address),
      16#44# => PM_String (Dev_44'Address),
      16#46# => PM_String (Dev_46'Address),
      16#48# => PM_String (Dev_48'Address),
      16#49# => PM_String (Dev_49'Address),
      16#4A# => PM_String (Dev_4A'Address),
      16#4C# => PM_String (Dev_4C'Address),
      16#50# => PM_String (Dev_50'Address),
      16#52# => PM_String (Dev_52'Address),
      16#53# => PM_String (Dev_53'Address),
      16#57# => PM_String (Dev_57'Address),
      16#58# => PM_String (Dev_58'Address),
      16#5A# => PM_String (Dev_5A'Address),
      16#5B# => PM_String (Dev_5B'Address),
      16#5C# => PM_String (Dev_5C'Address),
      16#5D# => PM_String (Dev_5D'Address),
      16#60# => PM_String (Dev_60'Address),
      16#61# => PM_String (Dev_61'Address),
      16#62# => PM_String (Dev_62'Address),
      16#63# => PM_String (Dev_63'Address),
      16#64# => PM_String (Dev_64'Address),
      16#66# => PM_String (Dev_66'Address),
      16#68# => PM_String (Dev_68'Address),
      16#69# => PM_String (Dev_69'Address),
      16#6A# => PM_String (Dev_6A'Address),
      16#70# => PM_String (Dev_70'Address),
      16#74# => PM_String (Dev_74'Address),
      16#76# => PM_String (Dev_76'Address),
      16#77# => PM_String (Dev_77'Address),
      others => Nil
     );

   --  In previous versions we used a generic
   --
   --  generic
   --     Str : AVR_String;
   --  package Generic_PM is
   --
   --     Str_PM : constant Text_In_Progmem := (Str'Length, Str);
   --     PM : constant PM_String :=
   --       (if Str'Length>0 then PM_String(Str_PM'Address) else Nil);
   --
   --  end Generic_PM;
   --
   --  Text_In_Progmem and PM_String are defined in
   --  AVR.Strings.Progmem with a Linker_Section attached to the type.
   --  AdaCore implemented Linker_Section for types in gcc-4.9 on
   --  request of AVR-Ada [J121-006 public].  That seems not to work
   --  anymore.  Even attaching a Linker_Section to Str_PM in above
   --  generic does not work anymore.  I therefor had to generate the
   --  Dev_XX with the prepended lengths of the strings in this file
   --  by an external program.
end I2C_Addresses;
