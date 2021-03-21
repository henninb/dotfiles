#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include "config.h"

#define DEBUG 1

/*
 * install ArduinoJson library
 char* serverName = "http://192.168.100.247:8080/weather";
 */

/*
  ESP12    |  FTDI
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX

  CHPD  - 3.3V
  GPIO15 - GND
  GPIO0  - GND

*/

const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 3600;
const int   daylightOffset_sec = 3600;
const float CST = -6.00;
const int EPOCH_1_1_2019 = 1546300800; //1546300800 =  01/01/2019 @ 12:00am (UTC)

int count = 0;

char incomingByte = 0;
char message[100] = {0};
int idx = 0;

time_t now;

String readInput() {
  String inData = "";
  while (Serial.available() > 0) {
    char received = Serial.read();
    inData += received;

        // Process message when new line character is received
    if (received == '\n') {
      Serial.print("Received from stm32f013: ");
      inData.trim();
      Serial.println(inData);
      return inData;
    }
  }
}

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup started.");
  pinMode(BUILTIN_LED, OUTPUT);

  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi.");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
  //configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  configTime(CST, 0, ntpServer);
  while (now < EPOCH_1_1_2019) {
    now = time(NULL);
    delay(500);
    Serial.print("*");
  }
  Serial.println("setup completed.");

}

void loop() {
  Serial.println("Hello from ESP01");
  /* digitalWrite(BUILTIN_LED, HIGH); */
  /* delay(1000); */
  /* digitalWrite(BUILTIN_LED, LOW); */
  /* delay(1000); */


  now = time(NULL);
  struct tm *timeinfo;

  time(&now);
  timeinfo = localtime(&now);

  int year = timeinfo->tm_year + 1900;
  int month = timeinfo->tm_mon + 1;
  int day = timeinfo->tm_mday;
  int hour = timeinfo->tm_hour;
  int mins = timeinfo->tm_min;
  int sec = timeinfo->tm_sec;
  int day_of_week = timeinfo->tm_wday;

  char timeString[25] = {0};
  sprintf(timeString, "%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, mins, sec);
  Serial.print("Timestamp: ");
  Serial.println(timeString);
  Serial.println("start");
  String result = readInput();


  if(WiFi.status()== WL_CONNECTED) {
    HTTPClient http;

    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");

    StaticJsonDocument<100> jsonStructure;
    jsonStructure["location"] = "garage";
    jsonStructure["timestamp"] = timeString;
    jsonStructure["temperature"] = result;

    String payload;
    serializeJson(jsonStructure, payload);
    Serial.print("Payload: ");
    Serial.println(payload);

    Serial.print("Sending post payload to: ");
    Serial.println(serverName);
    int httpResponseCode = http.POST(payload);
    Serial.print("HTTP response code: ");
    Serial.println(httpResponseCode);
    if(httpResponseCode != HTTP_CODE_OK ) {
      Serial.printf("[HTTP] POST failed: %s\n", http.errorToString(httpResponseCode).c_str());
    } else {
      String payload = http.getString();
      Serial.println(payload);
    }
    http.end();

    Serial.print("Connected with IP address: ");
    Serial.println(WiFi.localIP());
    delay(15000);
  }
}
