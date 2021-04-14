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

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("LoRa Receiver");
    // override the default CS, reset, and IRQ pins (optional)
  LoRa.setPins(PA4, PB1, PB0);// set CS, reset, IRQ pin
  /* LoRa.setPins(10, 3, 2); // set CS, reset, IRQ pin¬ */
  /* LoRa.setPins(ss, reset, dio0); */

  if (!LoRa.begin(915E6)) {
    Serial.println("setup LoRa failed!");
    while (1);
  }
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("LoRa Receiver setup completed.");
}

void loop() {
  /* Serial.println("LoRa Receiver will start receiving."); */
  // try to parse packet
  int packetSize = LoRa.parsePacket();
  if (packetSize) {
    // received a packet
    Serial.print("Received packet '");

    // read packet
    while (LoRa.available()) {
      Serial.print((char)LoRa.read());
    }

    // print RSSI of packet
    Serial.print("' with RSSI ");
    Serial.println(LoRa.packetRssi());
  }
}
