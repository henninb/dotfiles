/*
   git@github.com:jaretburkett/RF24-STM.git
   YL-105 Breakoutboard to stm32f103c
   GND -> GND (external)
   VCC -> 5v (external)
   CE -> pin PA0
   CS -> pin PA4
   SCK -> pin PA5
   MISO -> pin PA6
   MOSI -> pin PA7
 */

#include <SPI.h>
#include <RF24.h>
/* #include <RF24-STM.h> */

RF24 radio(PA0, PA4); // using pin PA0 for the CE pin, and pin PA4 for the CSN pin

char receivedPayload[100] = {};

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01
char buffer[50] = {0};
int length = 0;

void setup() {
  Serial.println(F("RF24 example receiver."));
  pinMode(PC13, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }

  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println(F("Receiving radio hardware is not responding."));
    while (1) {
      Serial.println("harware issue, wrong pin?");
      delay(7000);
    } // hold in infinite loop
  }

  /* radio.begin(); */
  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();

  radio.openReadingPipe(1, pipe); // Get NRF24L01 ready to receive
  /* radio.setPALevel(RF24_PA_MIN); */
  /* SPI.setClockDivider(SPI_CLOCK_DIV8) ; */
  radio.startListening(); // Listen to see if information received
}

void loop() {
  /* Serial.println("start receiving..."); */
  while (radio.available()) {
    /* Serial.println("radio is available"); */
    length = radio.getDynamicPayloadSize();  //# or radio.getPayloadSize() for static payload sizes¬
    radio.read(&receivedPayload, 32);
    sprintf(buffer, "received message = '%s' of length= %d", receivedPayload, length);
    Serial.println(buffer);
    digitalWrite(PC13, HIGH);
    delay(500);
    digitalWrite(PC13, LOW);
  }
}
