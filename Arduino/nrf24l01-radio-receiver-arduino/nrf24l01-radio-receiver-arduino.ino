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

struct tempDataType {
    signed int temperature; // 2 bytes, -32,768 to 32,767, same as short
    unsigned maxTemp;       // 2 bytes, 0 to 65,535
    double humidity;        // 4 bytes 32-bit floating point (Due=8 bytes, 64-bit)
    float dewPoint;         // 4 bytes 32-bit floating point, same as double
    byte ID;                // 1 byte
    // Total 13, you can have max 32 bytes here
};

RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin

/* char receivedPayload[100] = {}; */
tempDataType myDataRx;

const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01
char buffer[50] = {0};
int length = 0;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }
  Serial.println("RF24 example receiver.");

  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println("Receiving radio hardware is not responding.");
    while (1) {
      Serial.println("hardware issues");
      delay(1000);
    } // hold in infinite loop
  }

  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();

  radio.openReadingPipe(1, pipe); // Get NRF24L01 ready to receive
  /* radio.setPALevel(RF24_PA_MIN); */
  /* SPI.setClockDivider(SPI_CLOCK_DIV8) ; */
  radio.setAutoAck(true);
  radio.startListening(); // Listen to see if information received
  /* radio.printDetails(); */
}

void loop() {
  while (radio.available()) {
    radio.read(&myDataRx, sizeof(tempDataType));
    Serial.println("Receiving data ......");
    Serial.print("  PALevel (1 == RF24_PA_LOW): ");
    Serial.println(radio.getPALevel());
    Serial.print("  Channel: ");
    Serial.println(radio.getChannel());
    Serial.print("  ID         : ");
    Serial.println(myDataRx.ID);
    Serial.print("  Temperature: ");
    Serial.println(myDataRx.temperature);
    Serial.print("  Max Temp.  : ");
    Serial.println(myDataRx.maxTemp);
    Serial.print("  Humidity   : ");
    Serial.println(myDataRx.humidity);
    Serial.print("  Dew Point  : ");
    Serial.println(myDataRx.dewPoint);
    delay(10);
  }
}
