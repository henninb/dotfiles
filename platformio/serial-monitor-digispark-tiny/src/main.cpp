#include <Arduino.h>
#include "config.h"

/*
for serial monitor an FTDI is required

FTDI | digispark
================
5V   | VIN
GND  | GND
RX   | PB2
 */

#define DEBUG 1

void setup() {
  Serial.begin(9600);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  pinMode(1, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed...");
#endif
}

void loop() {
  Serial.println("Hello from attiny85 digispark");
  digitalWrite(1, HIGH);
  delay(1000);
  digitalWrite(1, LOW);
  delay(1000);
}
