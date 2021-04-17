#include <Arduino.h>
#include <SoftwareSerial.h>
#include "config.h"

/*
neo-6m can connect to 5V
*/

// Choose two Arduino pins to use for software serial
int RXPin = 2;
int TXPin = 3;

// Create a software serial port called "gpsSerial"
SoftwareSerial gpsSerial(RXPin, TXPin);

void setup() {
  // Start the Arduino hardware serial port at 9600 baud
  Serial.begin(9600);
  while(!Serial);
  gpsSerial.begin(9600);
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
