#include <SPI.h>
#include <RF24.h>
#include "config.h"

/*
   //not required however it works
   git@github.com:jaretburkett/RF24-STM.git

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

struct WeatherType {
    short temperature;           // 2 bytes
    short temperature_decimal;   // 2 bytes
    short humidity;              // 2 bytes
    short humidity_decimal;      // 2 bytes
    byte id;                     // 1 byte
    // Total 9, you can have max 32 bytes here
};

// instantiate an object for the nRF24L01 transceiver
RF24 radio(PB0, PA4); // using pin PB0 for the CE pin, and pin PA4 for the CSN pin

WeatherType myDataTx;

const uint64_t writePipe = 0xE6E6E6E6E6E6;
const uint64_t readPipe = 0xB3B4B5B601;

void setup() {
  pinMode(PC13, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }
  Serial.println("RF24 transmitter setup.");

  // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println("Receiving radio hardware is not responding.");
    while (1) {
      Serial.println("hardware issues");
      delay(1000);
    }
  }

  // Use a channel unlikely to be used by Wifi, Microwave ovens etc
  /* radio.setChannel(76); */
  /* // Give receiver a chance */
  /* radio.setRetries(200, 50); */
  radio.setAutoAck(true);
  /* radio.setPALevel(RF24_PA_LOW); */
  radio.setPALevel(RF24_PA_MAX);     // RF24_PA_MAX is default.
  radio.openReadingPipe(1, readPipe);
  radio.openWritingPipe(writePipe); // Get NRF24L01 ready to transmit
  radio.stopListening();
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("RF24 transmitter setup completed.");
}

void loop() {
    float temperature = 3.14;
    float humidity = 54.32;
    digitalWrite(PC13, LOW);
    myDataTx.id = 'B';
    myDataTx.temperature = (short) temperature;
    myDataTx.temperature_decimal = (temperature - myDataTx.temperature) * 1000;
    myDataTx.humidity = (short) humidity;
    myDataTx.humidity_decimal = (humidity - myDataTx.humidity) * 1000;
   if( !radio.write(&myDataTx, sizeof(myDataTx)) ) {
     /* radio.printDetails(); */
     Serial.println("radio write failed, the receiver is not online or responding.");
     Serial.println("radio write failed, transmitter may not have enough power.");
     Serial.print("  PALevel (1 == RF24_PA_LOW): ");
     Serial.println(radio.getPALevel());
     Serial.print("  DataRate: ");
     Serial.println(radio.getDataRate());
     Serial.print("  Channel: ");
     Serial.println(radio.getChannel());
     delay(500);
     return;
   } else {
     Serial.println("Transmitting data below......");
     Serial.print("  PALevel (1 == RF24_PA_LOW): ");
     Serial.println(radio.getPALevel());
     Serial.print("  Channel: ");
     Serial.println(radio.getChannel());
     Serial.print("  id: ");
     Serial.println(myDataTx.id);
     Serial.print("  Temperature Whole: ");
     Serial.println(myDataTx.temperature);
     Serial.print("  Temperature Decimal: ");
     Serial.println(myDataTx.temperature_decimal);
     Serial.print("  Humidity Whole: ");
     Serial.println(myDataTx.humidity);
     Serial.print("  Humidity Decimal: ");
     Serial.println(myDataTx.humidity_decimal);
   }
    digitalWrite(PC13, HIGH);
    delay(10000);
}
