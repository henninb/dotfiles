#include <ESP8266WiFi.h>
/*
  Hardware
  ========
  ESP01 programmer (modified)
  to program ensure the connection
  unplug after programming
*/

void setup() {
  Serial.begin(9600);
  while (!Serial);
  pinMode(LED_BUILTIN, OUTPUT);
  WiFi.mode(WIFI_STA);
}

void loop() {
  Serial.println("Hello from Wemos d1 Mini");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  Serial.println(millis() / 1000);
}
