#include <Arduino.h>

#define uploadTimestamp "2021-04-14 05:27:58"
#define DEBUG 1

void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup started...");
#endif

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
  Serial.println("Hello from Arduino");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(5000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(5000);
}
