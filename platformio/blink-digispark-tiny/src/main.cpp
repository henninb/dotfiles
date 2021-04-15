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

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
#ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
  Serial.println("Hello from attiny85 digispark");
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
