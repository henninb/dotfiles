#include <Arduino.h>
#include <WiFi.h>
#include <time.h>
#include <SD.h>
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

GPIO18 = SCK
GPIO19 = MISO
GPIO23 = MOSI
GPIO5 = CS
VCC = 5V
GND = GND
 */

const char ntpServer[] = "pool.ntp.org";
const long gmtOffset = -21600; //Central time -6
const int daylightOffset = 3600;

const int csPin = D8; //D8 = GPIO5

File fileHandle;

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

  if (SD.begin(csPin)) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println(csPin);
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    while(true);
  }

  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
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
  StaticJsonDocument<300> jsonStructure;
  char timestampString[25] = {0};

  fileHandle = SD.open("wifi-data.txt", FILE_WRITE);
  if (fileHandle) {
    Serial.println("file is open for writting...");
  } else {
    Serial.println("something went wrong with the file opening process.");
    /* while(true); */
  }

  if (networkCount == 0) {
    Serial.println("no networks found");
  } else {
    struct tm timeinfo = {0};
    if(! getLocalTime(&timeinfo) ){
      Serial.println("ERROR: Failed to obtain timestamp.");
    }
    strftime(timestampString, sizeof(timestampString), "%Y-%m-%d %H:%M:%S", &timeinfo);
    for (int index = 0; index < networkCount; ++index) {
      jsonStructure["timestamp"] = timestampString;
      jsonStructure["ssid"] = WiFi.SSID(index);
      jsonStructure["bssid"] = WiFi.BSSIDstr(index);
      jsonStructure["rssi"] = WiFi.RSSI(index);
      jsonStructure["channel"] = WiFi.channel(index);
      jsonStructure["encryptionType"] = translateEncryptionType(WiFi.encryptionType(index));

      String payload;
      serializeJson(jsonStructure, payload);
      Serial.print("Payload: ");
      Serial.println(payload);
      if( fileHandle ) {
        fileHandle.println(payload);
      } else {
        Serial.println("cannot write to file");
      }
      delay(10);
    }
  }
  fileHandle.close();
  Serial.println("scan done");
  Serial.println("");
  delay(5000);
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
}
