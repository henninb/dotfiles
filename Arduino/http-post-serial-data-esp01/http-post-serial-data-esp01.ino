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

/* time_t now; */

String getValue(String data, char separator, int index) {
  int found = 0;
  int strIndex[] = { 0, -1 };
  int maxIndex = data.length() - 1;

  for (int i = 0; i <= maxIndex && found <= index; i++) {
    if (data.charAt(i) == separator || i == maxIndex) {
      found++;
      strIndex[0] = strIndex[1] + 1;
      strIndex[1] = (i == maxIndex) ? i+1 : i;
    }
  }
  return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

String readInput() {
  String inData = "";
  int charCount = 0;
  Serial.println("readInput called.");
  while (Serial.available() > 0) {
    charCount++;
    Serial.println(".");
    char received = Serial.read();
    inData += received;

    if( charCount > 1000 ) {
      Serial.println("could there be a problem?");
    }

    if (received == '\n') {
      Serial.print("Received data from stm32f013: ");
      inData.trim();
      Serial.println(inData);
      return inData;
    }
  }

  Serial.println("empty return.");
  return "";
}

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("ESP01 setup started.");
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
  /* configTime(CST, 0, ntpServer); */
  /* while (now < EPOCH_1_1_2019) { */
  /*   now = time(NULL); */
  /*   delay(500); */
  /*   Serial.print("*"); */
  /* } */
  /* Serial.println(""); */
  Serial.println("ESP01 setup completed.");
}

void loop() {
  Serial.println("Hello from ESP01");
  /* digitalWrite(BUILTIN_LED, HIGH); */
  /* delay(1000); */
  /* digitalWrite(BUILTIN_LED, LOW); */
  /* delay(1000); */


  /* now = time(NULL); */
  /* struct tm *timeinfo; */

  /* time(&now); */
  /* timeinfo = localtime(&now); */

  /* int year = timeinfo->tm_year + 1900; */
  /* int month = timeinfo->tm_mon + 1; */
  /* int day = timeinfo->tm_mday; */
  /* int hour = timeinfo->tm_hour; */
  /* int mins = timeinfo->tm_min; */
  /* int sec = timeinfo->tm_sec; */
  /* int day_of_week = timeinfo->tm_wday; */

  /* char timeString[25] = {0}; */
  /* sprintf(timeString, "%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, mins, sec); */
  /* Serial.print("Timestamp: "); */
  /* Serial.println(timeString); */
  String payload;
  do {
    payload = readInput();
    Serial.print(".");
    /* delay(1); */
  } while ( payload.length() == 0 );
  Serial.println("");

  /* if(result.length() == 0 ) { */
  /*   Serial.println("Problem with the result data."); */
  /*   return; */
  /* } */
  /* Serial.print("ESP01 temperature: "); */
  /* Serial.println(temperature); */
  /* Serial.print("ESP01 humidity: "); */
  /* Serial.println(humidity); */
  /* Serial.print("ESP01 Result: "); */
  /* Serial.println(result); */


  if(WiFi.status()== WL_CONNECTED) {
    HTTPClient http;

    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");


    /* Serial.print("Sending post payload to: "); */
    /* Serial.println(serverName); */
    int httpResponseCode = http.POST(payload);
    /* Serial.print("HTTP response code: "); */
    /* Serial.println(httpResponseCode); */

    /* if(httpResponseCode != HTTP_CODE_OK ) { */
    /*   Serial.print("HTTP POST Failure: "); */
    /*   Serial.println(http.errorToString(httpResponseCode).c_str()); */
    /* } else { */
    /*   String payload = http.getString(); */
    /*   Serial.print("HTTP Response: "); */
    /*   Serial.println(payload); */
    /* } */
    /* http.end(); */

    /* Serial.print("Connected with IP address: "); */
    /* Serial.println(WiFi.localIP()); */
    /* delay(1000); */
  } else {
    Serial.println("not connected to the network.");
  }
}
