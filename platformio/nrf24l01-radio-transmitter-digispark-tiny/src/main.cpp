#include <RHReliableDatagram.h>
#include <RH_NRF24.h>
#include <tinySPI.h>
#include "config.h"

/*
NRF24L01(YL-105)   Arduino_ Uno    Arduino_Mega    Blue_Pill(stm32f01C)
  __________________________________________________________________________
  VCC        |       5v        |     5v        |     5v
  GND        |       GND       |     GND       |     GND
  CSN        |   Pin10 SPI/SS  | Pin10 SPI/SS  |     A4 NSS1 (PA4) 3.3v
  CE         |   Pin9          | Pin9          |     B0 digital (PB0) 3.3v
  SCK        |   Pin13         | Pin52         |     A5 SCK1   (PA5) 3.3v
  MISO       |   Pin11 (MOSI)  | Pin50         |     A7 MISI1  (PA7) 3.3v
  MOSI       |   Pin12 (MOS0)  | Pin51         |     A6 MOSO1  (PA6) 3.3v

 NOTE: MOSI is flipped with MISO
 */

/* #define __AVR_ATtiny85__ */

const uint64_t writePipe = 0xE6E6E6E6E6E6;
const uint64_t readPipe = 0xB3B4B5B601;

RH_NRF24 radio;
// RH_NRF24 radio(8, 7);   // For RFM73 on Anarduino Mini
//
RHReliableDatagram manager(radio, writePipe);

void setup() {
  Serial.begin(9600);
  while (!Serial);

  Serial.println("LoRa transmitter setup");

  if (!manager.init()) {
    Serial.println("init failed");
    while( true);
  }
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("radio transmitter setup completed");
}

void loop() {
}
