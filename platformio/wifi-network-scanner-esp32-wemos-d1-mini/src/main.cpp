#include <Arduino.h>
#include <WiFi.h>
#include <time.h>
/* #include <NTPClient.h> */
/* #include <WiFiUdp.h> */
#include <ArduinoJson.h>
#include "config.h"

/*
serial connection, programming mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
IO0 -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

serial connection, regular mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

1000uf cap to smooth the power between 3.3V and ground on the FTDI
 */

const char ntpServer[] = "pool.ntp.org";
const long gmtOffset = -21600; //Central time -6
const int daylightOffset = 3600;

void printLocalTime();

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  // Print local IP address and start web server
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  configTime(gmtOffset, daylightOffset, ntpServer);
  struct tm timeinfo = {0};
  getLocalTime(&timeinfo);

  /* WiFi.mode(WIFI_STA); */
  WiFi.mode(WIFI_OFF);
  WiFi.disconnect(true);
  delay(100);
  Serial.println("setup completed.");
}

String translateEncryptionType(wifi_auth_mode_t encryptionType) {
  switch (encryptionType) {
    case (0):
      return "Open";
    case (1):
      return "WEP";
    case (2):
      return "WPA_PSK";
    case (3):
      return "WPA2_PSK";
    case (4):
      return "WPA_WPA2_PSK";
    case (5):
      return "WPA2_ENTERPRISE";
    default:
      return "UNKOWN";
    }
}

void loop() {
  Serial.println("scanning...");
  int networkCount = WiFi.scanNetworks();
  StaticJsonDocument<200> jsonStructure;

  if (networkCount == 0) {
    Serial.println("no networks found");
  } else {
    /* Serial.println(timeClient.getFormattedDate()); */
    printLocalTime();
    for (int index = 0; index < networkCount; ++index) {
      jsonStructure["ssid"] = WiFi.SSID(index);
      jsonStructure["rssi"] = WiFi.RSSI(index);
      jsonStructure["channel"] = WiFi.channel(index);
      jsonStructure["encryptionType"] = translateEncryptionType(WiFi.encryptionType(index));

      String payload;
      serializeJson(jsonStructure, payload);
      Serial.print("Payload: ");
      Serial.println(payload);
      delay(10);
    }
  }
  Serial.println("scan done");
  Serial.println("");
  delay(5000);
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
}

void printLocalTime() {
  struct tm timeinfo = {0};
  if(! getLocalTime(&timeinfo) ){
    Serial.println("ERROR: Failed to obtain timestamp.");
    return;
  }
  Serial.println(&timeinfo, "%Y-%m-%d %H:%M:%S");
}
