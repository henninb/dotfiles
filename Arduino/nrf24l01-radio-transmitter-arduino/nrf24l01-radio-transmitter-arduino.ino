/*
   YL-105 Breakoutboard to Arduino
   GND -> GND
   VCC -> 5v
   CE -> pin 7
   CS -> pin 8
   SCK -> pin 13
   MISO -> pin 11
   MOSI -> pin 12
 */

#include <SPI.h>
#include <RF24.h>

// instantiate an object for the nRF24L01 transceiver
RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin

char *message = "xx";

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01
char buffer[50] = {0};

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }

  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();
  /* radio.printDetails(); */

  Serial.println("setup");
  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println(F("Transmitting radio hardware is not responding."));
    while (1) {} // hold in infinite loop
  }

  Serial.println(F("RF24 example transmitter."));
  radio.openWritingPipe(pipe); // Get NRF24L01 ready to transmit
}

void loop() {
   if(!radio.write(message, sizeof(message))){
     Serial.println("radio write is not transmitting as the receiver is not online or responding.");
   }else{
     sprintf(buffer, "transmit message = '%s'", message);
     Serial.println(buffer);
   }
  delay(1000);
  digitalWrite(LED_BUILTIN, (millis() / 1000) % 2);
}
