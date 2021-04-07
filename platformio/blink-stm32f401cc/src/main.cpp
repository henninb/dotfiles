#include <Arduino.h>

#define ledPin PC13

void setup() {
  Serial.begin(9600);
  while( !Serial);
  Serial.println("setup started...");
  pinMode(ledPin, OUTPUT);
  Serial.println("setup completed...");
}

void loop() {
  Serial.println("Hello from stm32f401");
  digitalWrite(ledPin, HIGH);
  delay(500);
  digitalWrite(ledPin, LOW);
  delay(500);
}
