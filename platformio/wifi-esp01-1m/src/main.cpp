#include <ESP8266WiFi.h>
#include <time.h>
#include "config.h"

/*
serial connection, programming mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
IO0 -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

serial connection, regular mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

1000uf cap to smooth the power between 3.3V and ground on the FTDI

GPIO18 = SCK
GPIO19 = MISO
GPIO23 = MOSI
GPIO5 = CS
VCC = 5V
GND = GND
 */

#define uploadTimestamp "2021-04-14 05:27:58"

const char ntpServer[] = "pool.ntp.org";
const long gmtOffset = -21600; //Central time -6
const int daylightOffset = 3600;

void setup() {
  Serial.begin(115200);
  while (!Serial);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  configTime(gmtOffset, daylightOffset, ntpServer);
  /* struct tm timeinfo = {0}; */
  /* getLocalTime(&timeinfo); */

  time_t now;
  struct tm * timeinfo = NULL;
  time(&now);
  timeinfo = localtime(&now);
  char timestampString[25] = {0};
  strftime(timestampString, sizeof(timestampString), "%Y-%m-%d %H:%M:%S", timeinfo);
  Serial.println(timestampString);
  WiFi.mode(WIFI_STA);
  /* WiFi.mode(WIFI_OFF); */
  /* WiFi.disconnect(true); */
  delay(100);

  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
}

void loop() {
  Serial.println(WiFi.localIP());
  delay(1000);
}
