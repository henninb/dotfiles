#include <Wire.h>
#include "config.h"

/*
 pcf8574 | stm32f103
 ====================
  SDA    | PB7
  SCL    | PB6
  5V     |  5V
  GND    | GND
 */

void setup() {
  Wire.begin();

  Serial.begin(9600);
  while (!Serial);
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("I2C Scanner setup completed.");
}

void loop() {
  int nDevices = 0;

  Serial.println("Scanning...");

  for (byte address = 1; address < 127; ++address) {
    Wire.beginTransmission(address);
    byte error = Wire.endTransmission();

    if (error == 0) {
      Serial.print("I2C device found at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.print(address, HEX);
      Serial.println("");

      ++nDevices;
    } else if (error == 4) {
      Serial.print("Unknown error at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.println(address, HEX);
    }
  }
  if (nDevices == 0) {
    Serial.println("No I2C devices found");
  } else {
    Serial.println("I2C scan completed.");
  }
  Serial.println("");
  delay(5000);
}
