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
//#include <RF24-STM.h>

// instantiate an object for the nRF24L01 transceiver
RF24 radio(PA0, PA4); // using pin PA0 for the CE pin, and pin PA4 for the CSN pin

int transmitMessage[1] = {0};
int val = 0;
char *message = "xx";

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01
char buffer[50] = {0};

void setup() {
  Serial.println("RF24 example transmitter.");
  pinMode(PC13, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }

  // initialize the transceiver on the SPI bus
  if ( !radio.begin() ) {
    Serial.println(F("Transmitting radio hardware is not responding."));
    while (1) {} // hold in infinite loop
  }
  //radio.begin();

  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  radio.openWritingPipe(pipe); // Get NRF24L01 ready to transmit
}

void loop() {
   if(!radio.write(message, sizeof(message))){
     Serial.println("radio write is not transmitting.");
   }else{
     sprintf(buffer, "transmit message = '%s'", message);
     Serial.println(buffer);
   }

  digitalWrite(PC13, HIGH);
  delay(500);
  digitalWrite(PC13, LOW);
  delay(500);
  /* delay(1000); */
}
