#include <Arduino.h>
#include "config.h"

#define ledPin PC13

void setup() {
  Serial.begin(9600);
  while( !Serial);
  Serial.println("setup started...");
  pinMode(LED_BUILTIN, OUTPUT);
  delay(2000);
  Serial.println("setup completed...");
}

void loop() {
  Serial.println("Hello from stm32f401");
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(250);
  digitalWrite(LED_BUILTIN, LOW);
  delay(250);
}
