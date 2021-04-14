#include <SPI.h>
#include <LoRa.h>


/*
 *
 *   RF95    | Arduino Uno | stm32f103
  ---------------------------------
  GND     | ??          | ??
  3.3V    | VCC         | 3.3
  DIO0    | 2           | B0 digital (PB0)
  NSS     | 10 (SS)     | A4 NSS1 (PA4) 3.3v
  SCK     | 13 (SCK)    | A5 SCK1   (PA5) 3.3v
  MISI    | 11 (MOSI)   | A7 MISI1  (PA7) 3.3v
  MISO    | 12 (MOS0)   | A6 MOSO1  (PA6) 3.3v
  */

#define uploadTimestamp "2021-04-14 05:27:58"

int counter = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("LoRa transmitter");
  delay(1000);

  LoRa.setPins(10, 3, 2); // set CS, reset, IRQ pin
  if (!LoRa.begin(915E6)) {
    Serial.println("Starting LoRa failed!");
    while (1);
  }
}

void loop() {
  Serial.print("Sending packet: ");
  Serial.println(counter);

  // send packet
  LoRa.beginPacket();
  LoRa.print("hello ");
  LoRa.print(counter);
  LoRa.endPacket(true);

  counter++;
  Serial.println("send message completed.");

  delay(5000);
}
