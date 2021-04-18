#include <TinyGPS++.h>
#include <ArduinoJson.h>
#include "config.h"

/*
FTDI | stm32f103
================
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V

stm32f103 | NEO-6M
==================
GND       | GND
5V        | VCC
PC3 (RX2) | TX
PC2 (TX2) | RX

*/

void displayInfo();

TinyGPSPlus gps;

HardwareSerial gpsSerial(USART2);   // or HardWareSerial Serial2 (PA3, PA2);

void setup() {
  Serial.begin(9600);
  while (!Serial);

  gpsSerial.begin(9600);
  while (!gpsSerial);
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete.");
}

void loop() {
  while (gpsSerial.available() > 0) { //while data is available
    if (gps.encode(gpsSerial.read())) {
      StaticJsonDocument<300> jsonStructure;
      if (gps.location.isValid()) {
        jsonStructure["latitude"] = String(gps.location.lat(), 6);
        jsonStructure["longitude"] = String(gps.location.lng(), 6);
      } else {
        jsonStructure["latitude"] = "";
        jsonStructure["longitude"] = "";
      }
      if (gps.date.isValid()) {
        int month = gps.date.month();
        int day = gps.date.day();
        int year = gps.date.year();
        char now[20] = {0};
        sprintf(now, "%04d-%02d-%02d", year, month, day);
        jsonStructure["date"] = now;
      } else {
        jsonStructure["date"] = "";
      }
      if (gps.time.isValid()) {
        int hour = gps.time.hour();
        int min = gps.time.minute();
        int sec = gps.time.second();
        char now[20] = {0};
        sprintf(now, "%02d:%02d:%02d", hour, min, sec);
        jsonStructure["time"] = now;
      } else {
        jsonStructure["time"] = "";
      }
      String payload;
      serializeJson(jsonStructure, payload);
      Serial.print("Payload: ");
      Serial.println(payload);

    }
  }
}

