/*
GND
Positive 5v on the YL-105 Breakoutboard
CS to Arduino pin 8 (defined in the code)
CE to Arduino pin 7 (defined in the code)
MOSI to Arduino pin 11 (mandatory)
MISO to Arduino pin 12 (mandatory)
SCK to Arduino pin 13 (mandatory)
 */
#include <SPI.h>
#include <RF24.h>

// instantiate an object for the nRF24L01 transceiver
RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin

int SentMessage[1] = {000};

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01 


void setup() {

  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }

  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println(F("Transmitting radio hardware is not responding."));
    while (1) {} // hold in infinite loop
  }

  Serial.println(F("RF24 example transmitter."));
  radio.openWritingPipe(pipe); // Get NRF24L01 ready to transmit
   
}

void loop() {

SentMessage[0] = 111;
radio.write(SentMessage, 1); // Send value through NRF24L01
Serial.println(F("sent message"));
delay(1000);
}
