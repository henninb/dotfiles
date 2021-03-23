/*
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
 */

#include <SPI.h>
#include <RF24.h>
/* #include <RF24-STM.h> */
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

struct WeatherType {
  short temperature;           // 2 bytes
  short temperature_decimal;   // 2 bytes
  short humidity;        // 2 bytes
  short humidity_decimal;        // 2 bytes
  byte id;                // 1 byte
  // Total 9, you can have max 32 bytes here
};

char payload[10] = {0};

RF24 radio(PB0, PA4); // using pin PA0 for the CE pin, and pin PA4 for the CSN pin

//LiquidCrystal_I2C lcd(0x27, 16, 2);
LiquidCrystal_I2C lcd(0x3f, 16, 2);

WeatherType rxData;
int consecutiveLoopCount = 0;

const uint64_t readerPipe = 0xE6E6E6E6E6E6;
const uint64_t writerPipe = 0xB3B4B5B601;

void setup() {
  pinMode(PC13, OUTPUT);
  Serial.begin(9600);
  while (!Serial);
  Serial.println("RF24 receiver setup.");
  /* lcd.begin(); */
  /* lcd.backlight(); */
  /* lcd.setCursor(0, 1); */
  /* lcd.clear(); */
  /* Wire.begin(); */

    // initialize the transceiver on the SPI bus
  if (!radio.begin()) {
    Serial.println("Receiving radio hardware is not responding.");
    while (1) {
      /* lcd.clear(); */
      /* lcd.print("hardware issue"); */
      Serial.println("hardware issues");
      delay(1000);
    }
  }

  radio.begin();

  /* radio.begin(); */
  radio.setPALevel(RF24_PA_LOW);     // RF24_PA_MAX is default.

  /* radio.setDataRate(RF24_2MBPS); */
  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();

  /* radio.setRetries(200, 50); */

  radio.openReadingPipe(1, readerPipe); // Get NRF24L01 ready to receive
  radio.openWritingPipe(writerPipe);
  /* radio.setPALevel(RF24_PA_MIN); */
  /* SPI.setClockDivider(SPI_CLOCK_DIV8) ; */
  radio.setAutoAck(true);
  radio.startListening(); // Listen to see if information received
  Serial.println("RF24 receiver setup complete.");
}

void loop() {
  radio.startListening();
  delay(200);
  while (radio.available()) {
    radio.read(&rxData, sizeof(rxData));
    Serial.println("Receiving data ......");
    Serial.print("  PALevel (1 == RF24_PA_LOW): ");
    Serial.println(radio.getPALevel());
    Serial.print("  Channel: ");
    Serial.println(radio.getChannel());
    Serial.print("  id: ");
    Serial.println(rxData.id);
    sprintf(payload, "%d.%d", rxData.temperature, rxData.temperature_decimal);
    Serial.print("  Temerature: ");
    Serial.println(payload);
    sprintf(payload, "%d.%d", rxData.humidity, rxData.humidity_decimal);
    Serial.print("  Humidity: ");
    Serial.println(payload);
    consecutiveLoopCount = 0;
    delay(10);
  }
  consecutiveLoopCount++;
  if( consecutiveLoopCount > 100 ) {
    Serial.println("INFO: Outer Loop count exceeded threshold of 100.");
    consecutiveLoopCount = 0;
  }
}
