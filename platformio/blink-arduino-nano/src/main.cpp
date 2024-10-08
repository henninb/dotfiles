#include <Arduino.h>
#include "config.h"

#define DEBUG 1

void setup() {
  Serial.begin(9600);
  while( !Serial);
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
  Serial.println("Hello from Arduino Nano");
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);

  Serial.print("LED_BUILTIN: ");
  Serial.println(LED_BUILTIN);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
