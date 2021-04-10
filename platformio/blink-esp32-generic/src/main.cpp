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

uint32_t chipId = 0;

void setup() {
  Serial.begin(115200);
  while (!Serial);
}

void loop() {
  Serial.println("Hello from ESP32dev");
  for(int i=0; i<17; i=i+8) {
    chipId |= ((ESP.getEfuseMac() >> (40 - i)) & 0xff) << i;
  }

  Serial.printf("ESP32 Chip model = %s Rev %d\n", ESP.getChipModel(), ESP.getChipRevision());
  Serial.printf("This chip has %d cores\n", ESP.getChipCores());
  Serial.print("Chip ID: ");
  Serial.println(chipId);
  delay(1000);
}
