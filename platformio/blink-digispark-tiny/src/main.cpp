#include <Arduino.h>

/*
for serial monitor an FTDI is required

FTDI | digispark
================
5V   | VIN
GND  | GND
RX   | PB2
 */

/* #define ledPin 1 */

#define uploadTimestamp "2021-04-14 05:27:58"
#define DEBUG 1

void setup() {
  Serial.begin(9600);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed...");
#endif
}

void loop() {
  Serial.println("Hello from attiny85 digispark");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
