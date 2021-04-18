#include <Arduino.h>
#include <SoftwareSerial.h>
#include "config.h"

/*
 neo-6m | arduino uno
 ====================
 RX     | TX (pin17)
 TX     | RX (pin16)
 GND    | GND
 VCC    | 5V
*/

int RXPin = 2;
int TXPin = 3;

SoftwareSerial gpsSerial(RXPin, TXPin);

void setup() {
  Serial.begin(9600);
  while(!Serial);
  gpsSerial.begin(9600);
  while(!gpsSerial);
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed");
}

void loop() {
  while (gpsSerial.available() > 0) {
    Serial.write(gpsSerial.read());
  }
}
