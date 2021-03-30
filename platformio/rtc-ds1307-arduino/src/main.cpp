#include <Arduino.h>
#include <RTClib.h>

RTC_DS1307 rtc;

#define DEBUG 1
void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  rtc.begin();
  /* while (!rtc); */

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
#ifdef DEBUG
  Serial.println("Hello from Arduino");
#endif
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
