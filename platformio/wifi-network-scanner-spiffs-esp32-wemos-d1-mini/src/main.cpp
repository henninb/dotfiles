#include <Arduino.h>
#include <WiFi.h>
#include <time.h>
#include <SPIFFS.h>
#include <ArduinoJson.h>
#include <PubSubClient.h>
#include "config.h"

/*

serial connection, programming mode
ESP32 | FTDI
============
VCC   | 3.3V
GND   | GND
IO0   | GND
TXD   | TX (RX usually, but this board is wierd)
RXD   | RX (TX usually, but this board is wierd)

serial connection, regular mode
ESP32 | FTDI
============
VCC   | 3.3V
GND   | GND
TXD   | TX (RX usually, but this board is wierd)
RXD   | RX (TX usually, but this board is wierd)

1000uf cap to smooth the power between 3.3V and ground on the FTDI

ESP32   | SDCard Reader
=======================
GPIO18  | SCK
GPIO19  | MISO
GPIO23  | MOSI
GPIO5   | CS
VCC     | 5V
GND     | GND

*/

const char ntpServer[] = "pool.ntp.org";
const long gmtOffset = -21600; //Central time -6
const int daylightOffset = 3600;

WiFiClient espClient;
PubSubClient mqttClient(espClient);

File fileHandle;
File fileReadHandle;

void listAllFiles();

void setup() {
  Serial.begin(115200);
  while (!Serial);

  WiFi.begin(ssid, password);
  while( WiFi.status() != WL_CONNECTED ) {
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

  WiFi.mode(WIFI_STA);
  /* WiFi.mode(WIFI_OFF); */
  /* WiFi.disconnect(true); */
  delay(100);

  mqttClient.setServer(mqttServer, 1883);
  if (mqttClient.connect("espClient")) {
    Serial.println("mqtt connected.");
  } else {
    Serial.println("mqtt connection failed.");
  }

  if( !SPIFFS.begin(true) ) {
    Serial.println("SPIFFS initialization failed");
    while(true);
  }

  fileReadHandle = SPIFFS.open("/wifi-data.json");
  Serial.print("File size: ");
  Serial.println(fileReadHandle.size());
  if(fileReadHandle) {
    Serial.println("has wifi data stored.");
    if (mqttClient.connected()) {
      while(fileReadHandle.available()) {
        String line = fileReadHandle.readStringUntil('\n');
        Serial.println(line);
        /* mqttClient.publish("wifi", line.c_str(), true); */
        mqttClient.publish("wifi", line.c_str());
      }
    }
  }
  fileReadHandle.close();

  int tBytes = SPIFFS.totalBytes();
  int uBytes = SPIFFS.usedBytes();
  Serial.print("Total bytes: ");
  Serial.println(tBytes);
  Serial.print("Used bytes: ");
  Serial.println(uBytes);

  SPIFFS.remove("/wifi-data.json");
  Serial.println("delete file");

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

  fileHandle = SPIFFS.open("/wifi-data.json", FILE_APPEND);
  if( fileHandle ) {
    Serial.println("file is open for writting...");
  } else {
    Serial.println("something went wrong with the file opening process.");
    while(true);
  }

  if( networkCount == 0 ) {
    Serial.println("no networks found");
  } else {
    struct tm timeinfo = {0};
    if( !getLocalTime(&timeinfo) ){
      Serial.println("ERROR: Failed to obtain timestamp.");
    }
    strftime(timestampString, sizeof(timestampString), "%Y-%m-%d %H:%M:%S", &timeinfo);
    for( int index = 0; index < networkCount; ++index ) {
      String my_ssid = WiFi.SSID(index);
      String bssid = WiFi.BSSIDstr(index);
      String channel = "";
      jsonStructure["timestamp"] = timestampString;
      if( ssid != NULL ) {
        jsonStructure["ssid"] = my_ssid;
      } else {
        Serial.println("null ssid");
        jsonStructure["ssid"] = "";
      }
      if( bssid != NULL ) {
        Serial.println(bssid.length());
        Serial.println(bssid[0]);
        jsonStructure["bssid"] = bssid;
      } else {
        Serial.println("null bssid");
        jsonStructure["bssid"] = "";
      }

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
  delay(5000);
}

void listAllFiles() {
  File root = SPIFFS.open("/");
  File file = root.openNextFile();

  while( file ){
    Serial.print("FILE: ");
    Serial.println(file.name());
    file = root.openNextFile();
  }
}
