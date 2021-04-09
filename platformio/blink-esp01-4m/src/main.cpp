#include <ESP8266WiFi.h>
#include "config.h"
/*
  Hardware
  ========
  ESP01 programmer (modified)
  to program ensure the connection
  unplug after programming
*/

const short int ledBuiltin = 2; //GPIO2, the LED_BUILTIN is incorrectly set to 1
void connectToWifi();
void flashSize();

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup");
  pinMode(ledBuiltin, OUTPUT);

  /* connectToWifi(); */
  WiFi.mode(WIFI_STA); //We don't want the ESP to act as an AP
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from ESP01-4m");
  flashSize();
  digitalWrite(ledBuiltin, HIGH);
  delay(1000);
  digitalWrite(ledBuiltin, LOW);
  delay(1000);
}

void connectToWifi() {
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi.");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
}

void flashSize() {
  uint32_t realSize = ESP.getFlashChipRealSize();
  uint32_t ideSize = ESP.getFlashChipSize();
  FlashMode_t ideMode = ESP.getFlashChipMode();

  Serial.printf("Flash real id:   %08X\n", ESP.getFlashChipId());
  Serial.printf("Flash real size: %u bytes\n", realSize);
  Serial.printf("Flash ide  size: %u bytes\n", ideSize);
  Serial.printf("Flash ide speed: %u Hz\n", ESP.getFlashChipSpeed());
  Serial.printf("Flash ide mode:  %s\n", (ideMode == FM_QIO ? "QIO" : ideMode == FM_QOUT ? "QOUT" : ideMode == FM_DIO ? "DIO" : ideMode == FM_DOUT ? "DOUT" : "UNKNOWN"));

  if (ideSize != realSize) {
    Serial.println("Flash Chip configuration wrong.");
  } else {
    Serial.println("Flash Chip configuration ok.");
  }
  Serial.println("");

  delay(1000);
}
