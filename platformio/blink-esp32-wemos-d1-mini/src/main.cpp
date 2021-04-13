#include <Arduino.h>

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
 */

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from ESP32");
  Serial.print("BUILTIN_LED: ");
  Serial.println(BUILTIN_LED);
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
}
