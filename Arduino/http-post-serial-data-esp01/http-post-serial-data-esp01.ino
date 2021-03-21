#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include "config.h"

#define DEBUG 1

/*
 * install ArduinoJson library
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

  //Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}


/* void getFlashDetails() { */

/*   uint32_t realSize = ESP.getFlashChipRealSize(); */
/*   uint32_t ideSize = ESP.getFlashChipSize(); */
/*   FlashMode_t ideMode = ESP.getFlashChipMode(); */

/*   Serial.printf("Flash real id:   %08X\n", ESP.getFlashChipId()); */
/*   Serial.printf("Flash real size: %u bytes\n\n", realSize); */

/*   Serial.printf("Flash ide  size: %u bytes\n", ideSize); */
/*   Serial.printf("Flash ide speed: %u Hz\n", ESP.getFlashChipSpeed()); */
/*   Serial.printf("Flash ide mode:  %s\n", (ideMode == FM_QIO ? "QIO" : ideMode == FM_QOUT ? "QOUT" : ideMode == FM_DIO ? "DIO" : ideMode == FM_DOUT ? "DOUT" : "UNKNOWN")); */

/*   if (ideSize != realSize) { */
/*     Serial.println("Flash Chip configuration wrong!"); */
/*   } else { */
/*     Serial.println("Flash Chip configuration ok."); */
/*   } */

/*   delay(5000); */
/* } */

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
  /* while( Serial.available() == 0 ) { */
  /*   count++; */
  /*   if( count > 1000 ) { */
  /*     Serial.println("1000 times it was not available"); */
  /*     /1* delay(100); *1/ */
  /*     break; */
  /*   } */
  /* } //while no input on the serial device */
  /* count = 0; */
  /* while( Serial.available() ) { */
  /*   /1* Serial.println("in avail loop"); *1/ */
  /*   incomingByte = (char) Serial.read(); */
  /*   if( incomingByte == '\n' ) { */
  /*     idx = 0; */
  /*     /1* if( strlen(message) > 0 ) { *1/ */
  /*     Serial.print("from stm32f013: "); */
  /*     Serial.println(message); */
  /*     /1* } *1/ */
  /*     memset(message, '\0', sizeof(message)); */
  /*     break; */
  /*   } else { */
  /*     message[idx] = incomingByte; */
  /*     idx++; */
  /*   } */
  /* } */
  /* String value = Serial.readString(); */
  /* if( value.length() > 0 ) { */
  /*   Serial.print("value: "); */
  /*   Serial.println(value); */
  /* } */
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

    Serial.print("Sending post payload to http://");
    Serial.println(serverName);
    int httpResponseCode = http.POST(payload);
    Serial.print("HTTP response code: ");
    Serial.println(httpResponseCode);

    Serial.print("Connected with IP address: ");
    Serial.println(WiFi.localIP());
    delay(15000);
  }
}
