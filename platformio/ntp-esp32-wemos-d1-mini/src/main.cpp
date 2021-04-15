#include <Arduino.h>
#include <WiFi.h>
#include <time.h>
#include "config.h"

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
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  configTime(gmtOffset, daylightOffset, ntpServer);
  struct tm timeinfo = {0};
  getLocalTime(&timeinfo);

  WiFi.disconnect(true);
  WiFi.mode(WIFI_OFF);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
}

void loop() {
  for(int index = 0; index < 17; index = index + 8) {
    chipId |= ((ESP.getEfuseMac() >> (40 - index)) & 0xff) << index;
  }

  Serial.printf("ESP32 Chip model = %s Rev %d\n", ESP.getChipModel(), ESP.getChipRevision());
  Serial.printf("This chip has %d cores\n", ESP.getChipCores());
  Serial.print("Chip ID: ");
  Serial.println(chipId);

    digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
  printLocalTime();
}
