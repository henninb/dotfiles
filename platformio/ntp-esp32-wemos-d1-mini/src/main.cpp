#include <Arduino.h>
#include <WiFi.h>
#include <time.h>
#include "config.h"

//const char ssid[]      = "";
//const char password[]   = "";

uint32_t chipId = 0;

const char* ntpServer = "pool.ntp.org";
const long  gmtOffset = -21600;
const int   daylightOffset = 3600;

void printLocalTime() {
  struct tm timeinfo = {0};
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return;
  }
  Serial.println(&timeinfo, "%Y-%m-%d %H:%M:%S");
}

void setup() {
  Serial.begin(115200);
  while(!Serial);

  Serial.printf("Connecting to %s ", ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
  }
  Serial.println(" CONNECTED");

  configTime(gmtOffset, daylightOffset, ntpServer);
  printLocalTime();

  WiFi.disconnect(true);
  WiFi.mode(WIFI_OFF);
}

void loop() {
  for(int index=0; index<17; index=index+8) {
    chipId |= ((ESP.getEfuseMac() >> (40 - index)) & 0xff) << index;
  }

  Serial.printf("ESP32 Chip model = %s Rev %d\n", ESP.getChipModel(), ESP.getChipRevision());
  Serial.printf("This chip has %d cores\n", ESP.getChipCores());
  Serial.print("Chip ID: "); Serial.println(chipId);

  delay(3000);
  printLocalTime();
}
