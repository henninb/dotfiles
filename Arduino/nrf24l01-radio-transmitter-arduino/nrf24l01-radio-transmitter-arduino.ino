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

struct data {
    signed int temperature; // 2 bytes, -32,768 to 32,767, same as short
    unsigned maxTemp;       // 2 bytes, 0 to 65,535
    double humidity;        // 4 bytes 32-bit floating point (Due=8 bytes, 64-bit)
    float dewPoint;         // 4 bytes 32-bit floating point, same as double
    byte ID;                // 1 byte
    // Total 13, you can have max 32 bytes here
};

// instantiate an object for the nRF24L01 transceiver
RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin

data myDataTx;

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01
char buffer[50] = {0};

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }
  Serial.println("RF24 example transmitter.");

  /* radio.setChannel(104); */

  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();
  /* radio.printDetails(); */

  Serial.println("transmitter setup.");
  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println("Transmitting radio hardware is not responding.");
    while (1) {
      Serial.println("hardware issues");
      delay(1000);
    } // hold in infinite loop
  }

  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  radio.openWritingPipe(pipe); // Get NRF24L01 ready to transmit
}

void loop() {
    myDataTx.ID = 'B';
    myDataTx.temperature = 72;
    myDataTx.maxTemp = 93;
    myDataTx.humidity = 50.37;
    myDataTx.dewPoint = 69.4;
   if( !radio.write(&myDataTx, sizeof(myDataTx)) ) {
     Serial.println("radio write is not transmitting as the receiver is not online or responding.");
   } else {
     Serial.println("\nTransmitting data below......");
     Serial.print("  PALevel (1 == RF24_PA_LOW): ");
     Serial.println(radio.getPALevel());
     Serial.print("  Channel: ");
     Serial.println(radio.getChannel());
     Serial.print("  ID         : ");
     Serial.println(myDataTx.ID);
     Serial.print("  Temperature: ");
     Serial.println(myDataTx.temperature);
     Serial.print("  Max Temp.  : ");
     Serial.println(myDataTx.maxTemp);
     Serial.print("  Humidity   : ");
     Serial.println(myDataTx.humidity);
     Serial.print("  Dew Point  : ");
     Serial.println(myDataTx.dewPoint);
   }
  delay(1000);
  digitalWrite(LED_BUILTIN, (millis() / 1000) % 2);
}
