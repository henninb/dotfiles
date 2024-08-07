#include <Arduino.h>
#include <RTClib.h>
#include "config.h"

#define DEBUG 1

RTC_DS1307 rtc;

void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  if (! rtc.begin()) {
    Serial.println("failed rtc");
    while (true);
  }

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));//auto update from computer time
  //rtc.adjust(DateTime(2021, 4, 1, 5, 0, 0));// to set the time manualy
  #ifdef DEBUG
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed...");
#endif
}

void loop() {
#ifdef DEBUG
  Serial.println("Hello from Arduino");
#endif

  DateTime now = rtc.now();
  String time = String(now.hour()) + ":" + String(now.minute()) + ":" + String(now.second());
  String date = String(now.year()) + "-" + String(now.month()) + "-" + String(now.day());
  Serial.println(date + " " + time);

  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
