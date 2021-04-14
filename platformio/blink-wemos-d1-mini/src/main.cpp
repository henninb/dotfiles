#include <ESP8266WiFi.h>
/*
  Hardware
  ========
  ESP01 programmer (modified)
  to program ensure the connection
  unplug after programming
*/

#define uploadTimestamp "2021-04-14 05:27:58"

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(LED_BUILTIN, OUTPUT);
  WiFi.mode(WIFI_STA);
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from Wemos d1 Mini");
  Serial.print("LED_BUILTIN: ");
  Serial.println(LED_BUILTIN);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
