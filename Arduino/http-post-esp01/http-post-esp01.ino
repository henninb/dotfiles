#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
//#include <Arduino_JSON.h>
#include <ArduinoJson.h>
//#include <time.h>
#include "config.h"

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

time_t now;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);

  WiFi.begin(ssid, password);
  Serial.println("Connecting");
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

  //Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}


void getFlashDetails() {

  uint32_t realSize = ESP.getFlashChipRealSize();
  uint32_t ideSize = ESP.getFlashChipSize();
  FlashMode_t ideMode = ESP.getFlashChipMode();

  Serial.printf("Flash real id:   %08X\n", ESP.getFlashChipId());
  Serial.printf("Flash real size: %u bytes\n\n", realSize);

  Serial.printf("Flash ide  size: %u bytes\n", ideSize);
  Serial.printf("Flash ide speed: %u Hz\n", ESP.getFlashChipSpeed());
  Serial.printf("Flash ide mode:  %s\n", (ideMode == FM_QIO ? "QIO" : ideMode == FM_QOUT ? "QOUT" : ideMode == FM_DIO ? "DIO" : ideMode == FM_DOUT ? "DOUT" : "UNKNOWN"));

  if (ideSize != realSize) {
    Serial.println("Flash Chip configuration wrong!\n");
  } else {
    Serial.println("Flash Chip configuration ok.\n");
  }

  delay(5000);
}

void loop() {
  Serial.println("Hello from ESP01");
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);


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
  Serial.print("Time is: ");
  Serial.println(timeString);

  if(WiFi.status()== WL_CONNECTED) {
    HTTPClient http;

    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");

    StaticJsonDocument<100> jsonStructure;
    jsonStructure["fieldName"] = "fieldValue";
    jsonStructure["Random"] = String(random(40));
    String payload;
    serializeJson(jsonStructure, payload);
    Serial.println(payload);

    int httpResponseCode = http.POST(payload);
    Serial.println(httpResponseCode);

    //uint32 x = spi_flash_get_id();
    //SPIFFS.info(fs_info);
    getFlashDetails();

  //Serial.println(millis() / 1000);

    Serial.println("connected");
    Serial.println(WiFi.localIP());
  }
}
