#include <Arduino.h>
#include "config.h"

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);
  delay(2000);
  Serial.println("setup complete...");
}

void loop() {
  Serial.println("Hello from ESP32");
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);

  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
}
