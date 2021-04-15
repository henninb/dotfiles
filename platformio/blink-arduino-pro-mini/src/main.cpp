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

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello from Arduino Pro Mini");
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);

  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(5000);                       // wait for a second
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(5000);                       // wait for a second
}
