#include <WiFi.h>
#include <TinyGPS++.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>
#include <PubSubClient.h>
#include "config.h"

/*
5V neo-6m

*/

#define RXD2 16
#define TXD2 17
const int ledPin = 2;

void displayInfo();

TinyGPSPlus gps;
WiFiClient espClient;
PubSubClient mqttClient(espClient);

/* HardwareSerial ss(USART1);   // or HardWareSerial ss (PA3, PA2); */
/* HardWareSerial ss (PA3, PA2); */
SoftwareSerial ss(RXD2, TXD2);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  pinMode(ledPin,OUTPUT);

  ss.begin(9600);
  /* Serial2.begin(9600, SERIAL_8N1, RXD2, TXD2); */
  while (!ss);

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
  while ( ss.available() > 0 ) {
    if (gps.encode(ss.read())) {
      displayInfo();
    } else {
      Serial.println("no serial data available");
      delay(500);
      /* Serial.print("data: "); */
      /* Serial.write(ss.read()); */
      /* Serial.println(""); */
    }
  }

  // If 5000 milliseconds pass and there are no characters coming in
  // over the software serial port, show a "No GPS detected" error
  /* if (millis() > 5000 && gps.charsProcessed() < 10) { */
  /*   Serial.println("No GPS detected"); */
  /*     delay(250); */
  /*   /1* while(true); *1/ */
  /* } */
}

void displayInfo() {
    StaticJsonDocument<300> jsonStructure;
    String time = "";

  if( gps.location.isValid() ) {
    digitalWrite(ledPin, HIGH);
    delay(1000);
    digitalWrite(ledPin, LOW);
    delay(1000);
    jsonStructure["latitude"] = String(gps.location.lat(), 6);
    jsonStructure["longitude"] = String(gps.location.lng(), 6);
    Serial.println("found lon and lat.");
  } else {
    Serial.println("Location data is not vaild from the gps.");
    jsonStructure["latitude"] = "";
    jsonStructure["longitude"] = "";
    digitalWrite(ledPin, HIGH);
    delay(250);
    digitalWrite(ledPin, LOW);
    delay(250);
    digitalWrite(ledPin, HIGH);
    delay(250);
    digitalWrite(ledPin, LOW);
    delay(250);
  }

  if( gps.date.isValid() ) {
    int month = gps.date.month();
    int day = gps.date.day();
    int year = gps.date.year();
    char now[20] = {0};

    sprintf(now, "%04d-%02d-%02d", year, month, day);

    jsonStructure["date"] = now;
  } else {
    jsonStructure["date"] = "";
    Serial.println("Date data is not vaild from the gps.");
  }

  if( gps.time.isValid() ) {
    int hour = gps.time.hour();
    int min = gps.time.minute();
    int sec = gps.time.second();

    char now[20] = {0};

    sprintf(now, "%02d:%02d:%02d", hour, min, sec);
    jsonStructure["time"] = now;
  } else {
    jsonStructure["time"] = "";
    Serial.println("Time data is not vaild from the gps.");
  }

  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);

  if (mqttClient.connected()) {
    mqttClient.publish("ynot", payload.c_str());
    Serial.print("sent message to ynot: ");
    Serial.println(payload);
    delay(10);
  }

  Serial.println();
  delay(5000);
}
