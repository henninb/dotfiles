#include <Arduino.h>

/*
serial connection, programming mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
IO0 -> GND
TXD -> RX
RXD -> TX

serial connection, regular mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
TXD -> RX
RXD -> TX

1000uf cap to smooth the power between 3.3V and ground on the FTDI
 */

#define uploadTimestamp "2021-04-14 05:27:58"

uint32_t chipId = 0;

void setup() {
  Serial.begin(115200);
  while (!Serial);
  Serial.println("setup complete.");
}

void loop() {
  Serial.println("Hello from ESP32-generic");
  for(int idx = 0; idx < 17; idx= idx + 8) {
    chipId |= ((ESP.getEfuseMac() >> (40 - idx)) & 0xff) << idx;
  }

  Serial.printf("ESP32 Chip model = %s Rev %d\n", ESP.getChipModel(), ESP.getChipRevision());
  Serial.printf("This chip has %d cores\n", ESP.getChipCores());
  Serial.print("Chip ID: ");
  Serial.println(chipId);
  delay(1000);
}
