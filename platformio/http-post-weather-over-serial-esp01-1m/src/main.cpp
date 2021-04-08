#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <ArduinoJson.h>
#include "config.h"

#define DEBUG 1

#define ledBuiltin 2
/*
 * install ArduinoJson library
 char* serverName = "http://192.168.100.247:8080/weather";
 */

/*
  ESP01    | FTDI
  ===============
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX

  CHPD  - 3.3V
  GPIO15 - GND
  GPIO0  - GND
  1000 uf capacitor required to smooth out the power

*/

/* const char* ntpServer = "pool.ntp.org"; */
/* const long  gmtOffset_sec = 3600; */
/* const int   daylightOffset_sec = 3600; */
/* const float CST = -6.00; */
/* const int EPOCH_1_1_2019 = 1546300800; //1546300800 =  01/01/2019 @ 12:00am (UTC) */

int count = 0;

char incomingByte = 0;
char message[100] = {0};
int idx = 0;

/* String getValue(String data, char separator, int index) { */
/*   int found = 0; */
/*   int strIndex[] = { 0, -1 }; */
/*   int maxIndex = data.length() - 1; */

/*   for (int i = 0; i <= maxIndex && found <= index; i++) { */
/*     if (data.charAt(i) == separator || i == maxIndex) { */
/*       found++; */
/*       strIndex[0] = strIndex[1] + 1; */
/*       strIndex[1] = (i == maxIndex) ? i+1 : i; */
/*     } */
/*   } */
/*   return found > index ? data.substring(strIndex[0], strIndex[1]) : ""; */
/* } */

String readInput() {
  String inData = "";
  int charCount = 0;
  Serial.println("");
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
  delay(1000);
  return "";
}

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("ESP01 setup...");
  pinMode(ledBuiltin, OUTPUT);

  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi.");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
  digitalWrite(ledBuiltin, HIGH);
  delay(1000);
  digitalWrite(ledBuiltin, LOW);
  delay(1000);
  Serial.println("ESP01 setup completed.");
}

void loop() {
#ifdef DEBUG
  Serial.println("Hello from ESP01");
#endif
  String payload;
  do {
    payload = readInput();
    Serial.print(".");
  } while ( payload.length() == 0 );
  Serial.println("");

  Serial.println("preparing to send data.");
  if(WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    WiFiClient client;
    http.begin(client, serverName);

    /* http.begin(serverName); */
    http.addHeader("Content-Type", "application/json");
    int httpResponseCode = http.POST(payload);
    http.end();
  } else {
  #ifdef DEBUG
    Serial.println("not connected to the network.");
  #endif
  }
}
