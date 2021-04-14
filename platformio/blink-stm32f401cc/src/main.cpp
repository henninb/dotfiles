#include <Arduino.h>

#define uploadTimestamp "2021-04-14 05:27:58"
#define ledPin PC13

void setup() {
  Serial.begin(9600);
  while( !Serial);
  Serial.println("setup started...");
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.println("setup completed...");
}

void loop() {
  Serial.println("Hello from stm32f401");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(250);
  digitalWrite(LED_BUILTIN, LOW);
  delay(250);
}
