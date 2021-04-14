#include <Arduino.h>
#include <Wire.h>

#define uploadTimestamp "2021-04-14 05:27:58"

/*
 pcf8574 | esp01-1m
 =======================
  SDA    | GPIO0
  SCL    | GPIO2
  5V     | 5V (external)
  GND    | GND
note: shard ground is required for external
 */
void setup() {
  Wire.begin();

  Serial.begin(115200);
  while (!Serial);
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
