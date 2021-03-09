/*
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
#include <RF24.h>

struct tempDataType {
    signed int temperature; // 2 bytes, -32,768 to 32,767, same as short
    unsigned maxTemp;       // 2 bytes, 0 to 65,535
    double humidity;        // 4 bytes 32-bit floating point (Due=8 bytes, 64-bit)
    float dewPoint;         // 4 bytes 32-bit floating point, same as double
    byte ID;                // 1 byte
    // Total 13, you can have max 32 bytes here
};

// instantiate an object for the nRF24L01 transceiver
RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin

tempDataType myDataTx;

const uint64_t writePipe = 0xE6E6E6E6E6E6;
const uint64_t readPipe = 0xB3B4B5B601;

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

  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println("Transmitting radio hardware is not responding.");
    while (1) {
      Serial.println("hardware issues");
      delay(1000);
    } // hold in infinite loop
  }

  radio.setAutoAck(true);
  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.
  radio.openReadingPipe(1, readPipe);
  radio.openWritingPipe(writePipe); // Get NRF24L01 ready to transmit
}

void loop() {
    radio.stopListening();
    myDataTx.ID = 'B';
    myDataTx.temperature = 72;
    myDataTx.maxTemp = 93;
    myDataTx.humidity = 50.37;
    myDataTx.dewPoint = 69.4;
   if( !radio.write(&myDataTx, sizeof(myDataTx)) ) {
     Serial.println("radio write failed, the receiver is not online or responding.");
   } else {
     Serial.println("Transmitting data below......");
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
  /* delay(1000); */
  digitalWrite(LED_BUILTIN, (millis() / 1000) % 2);

      // Now listen for a response
    radio.startListening();

    // But we won't listen for long
    unsigned long started_waiting_at = millis();

    // Loop here until we get indication that some data is ready for us to read (or we time out)
    while (!radio.available()) {
        // Oh dear, no response received within our timescale
        if (millis() - started_waiting_at > 250) {
            Serial.print("  TX: Got no reply ");
            delay(2000);
            return;
        }
    }
    radio.read(&myDataTx, sizeof(myDataTx));
    delay(250);
}
