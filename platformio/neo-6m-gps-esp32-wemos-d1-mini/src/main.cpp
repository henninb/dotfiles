#include <WiFi.h>
#include <TinyGPS++.h>
#include <ArduinoJson.h>
#include <HardwareSerial.h>
#include <PubSubClient.h>
#include <SPIFFS.h>
#include "config.h"

/*
 neo-6m | esp32-wemos-d1-mini
 ====================
 RX     | TX (pin17)
 TX     | RX (pin16)
 GND    | GND
 VCC    | 5V
*/

#define RXD2 16
#define TXD2 17
const int ledPin = 2;
String fileName = "/gps-data.json";
String mqttTopic = "gps";

TinyGPSPlus gps;
WiFiClient espClient;
PubSubClient mqttClient(espClient);

/* SoftwareSerial gpsSerial(RXD2, TXD2); */
HardwareSerial gpsSerial(2);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  pinMode(ledPin,OUTPUT);

  gpsSerial.begin(9600);
  /* gpsSerial.begin(9600, SERIAL_8N1, RXD2, TXD2); */
  while (!gpsSerial);

  if( !SPIFFS.begin(true) ) {
    Serial.println("SPIFFS initialization failed.");
    while(true);
  }

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    if( millis()/1000 > 100 ) {
      break;
    }
  }
  if( WiFi.status() == WL_CONNECTED ) {
    Serial.println("");
    Serial.println("WiFi connected.");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("");
    Serial.println("WiFi NOT connected.");
  }
  WiFi.mode(WIFI_STA);

  if( WiFi.status() == WL_CONNECTED ) {
    mqttClient.setServer(mqttServer, 1883);
    if (mqttClient.connect("espClient")) {
      Serial.println("mqtt connected.");
      File fileReadHandle = SPIFFS.open(fileName);
      Serial.print("File size: ");
      Serial.println(fileReadHandle.size());
      if( fileReadHandle ) {
        while( fileReadHandle.available() ) {
          String record = fileReadHandle.readStringUntil('\n');
          Serial.println(record);
          mqttClient.publish(mqttTopic.c_str(), record.c_str());
        }
      }
      fileReadHandle.close();
    } else {
      Serial.println("mqtt connection failed.");
    }
  }

  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete.");
}

void loop() {
  while( gpsSerial.available() > 0 ) {
    if( gps.encode(gpsSerial.read()) ) {
      StaticJsonDocument<300> jsonStructure;
      char timestampNow[25] = {0};
      int month = 0;
      int day = 0;
      int year = 0;
      int hour = 0;
      int min = 0;
      int sec = 0;
      if( gps.location.isValid() ) {
        jsonStructure["latitude"] = String(gps.location.lat(), 6);
        jsonStructure["longitude"] = String(gps.location.lng(), 6);
      } else {
        jsonStructure["latitude"] = "";
        jsonStructure["longitude"] = "";
        delay(1000);
        return;
      }
      if( gps.date.isValid() ) {
        month = gps.date.month();
        day = gps.date.day();
        year = gps.date.year();
      } else {
        Serial.println("date is not valid.");
        delay(1000);
        return;
      }
      if( gps.time.isValid() ) {
        hour = gps.time.hour();
        min = gps.time.minute();
        sec = gps.time.second();
      } else {
        Serial.println("time is not valid.");
        delay(1000);
        return;
      }

      sprintf(timestampNow, "%04d-%02d-%02dT%02d:%02d:%02d +0000", year, month, day, hour, min, sec);
      jsonStructure["timestamp"] = timestampNow;
      String payload;
      serializeJson(jsonStructure, payload);
      Serial.print("Payload: ");
      Serial.println(payload);

      if( WiFi.status() == WL_CONNECTED && mqttClient.connected() ) {
        mqttClient.publish(mqttTopic.c_str(), payload.c_str());
        Serial.println("sent message to payload");
        delay(10);
      } else {
        File fileHandle = SPIFFS.open(fileName, FILE_APPEND);
        if( fileHandle ) {
          Serial.println("file is open for writting...");
          fileHandle.println(payload);
          fileHandle.close();
        } else {
          Serial.println("something went wrong with the file opening process.");
        }
      }
    }
  }
}
