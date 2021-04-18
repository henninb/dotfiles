#include <WiFi.h>
#include <TinyGPS++.h>
#include <ArduinoJson.h>
#include <HardwareSerial.h>
#include <PubSubClient.h>
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

TinyGPSPlus gps;
WiFiClient espClient;
PubSubClient mqttClient(espClient);

/* HardwareSerial gpsSerial(USART1);   // or HardWareSerial gpsSerial (RXD2, TXD2); */
/* SoftwareSerial gpsSerial(RXD2, TXD2); */
HardwareSerial gpsSerial(2);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  pinMode(ledPin,OUTPUT);

  gpsSerial.begin(9600);
  /* Serial2.begin(9600, SERIAL_8N1, RXD2, TXD2); */
  while (!gpsSerial);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  mqttClient.setServer(mqttServer, 1883);
  if (mqttClient.connect("espClient")) {
    Serial.println("mqtt connected.");
  } else {
    Serial.println("mqtt connection failed.");
  }

  WiFi.mode(WIFI_STA);

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
