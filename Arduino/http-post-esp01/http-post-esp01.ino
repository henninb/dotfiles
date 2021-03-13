#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <Arduino_JSON.h>
#include "config.h"

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

  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
}

void loop() {
  Serial.println("Hello from ESP01");
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);

  if(WiFi.status()== WL_CONNECTED) {
    HTTPClient http;
      
    http.begin(serverName);
    http.addHeader("Content-Type", "application/json");
    String payload = "{\"api_key\":\"fieldName\",\"fieldValue\":\"" + String(random(40)) + "\"}";           
    int httpResponseCode = http.POST(payload);

  
  //Serial.println(millis() / 1000);
  
    Serial.println("connected");
    Serial.println(WiFi.localIP());
  }
}
