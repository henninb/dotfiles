/*
   git@github.com:jaretburkett/RF24-STM.git

   NRF24L01(YL-105)   Arduino_ Uno    Arduino_Mega    Blue_Pill(stm32f01C)
  __________________________________________________________________________
  VCC        |       5v        |     5v        |     5v
  GND        |       GND       |     GND       |     GND
  CSN        |   Pin10 SPI/SS  | Pin10 SPI/SS  |     A4 NSS1 (PA4) 3.3v
  CE         |   Pin9          | Pin9          |     B0 digital (PB0) 3.3v
  SCK        |   Pin13         | Pin52         |     A5 SCK1   (PA5) 3.3v
  MISO       |   Pin12         | Pin50         |     A6 MISO1  (PA6) 3.3v
  MOSI       |   Pin11         | Pin51         |     A7 MOSI1  (PA7) 3.3v

 */

#include <SPI.h>
//#include <RF24.h>
#include <RF24-STM.h>

// instantiate an object for the nRF24L01 transceiver
RF24 radio(PB0, PA4); // using pin PB0 for the CE pin, and pin PA4 for the CSN pin

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
  /* if ( !radio.begin() ) { */
  /*   Serial.println(F("Transmitting radio hardware is not responding.")); */
  /*   while (1) {} // hold in infinite loop */
  /* } */
  radio.begin();

  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.


  radio.setDataRate(RF24_2MBPS);

  // Use a channel unlikely to be used by Wifi, Microwave ovens etc 124
  //radio.setChannel(104);

  // Give receiver a chance
  radio.setRetries(200, 50);
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
