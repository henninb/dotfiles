#include <Arduino.h>
#include <SPI.h>
#include <RF24.h>
#include <DHT.h>

/*
   NRF24L01(YL-105)   Arduino_ Uno    Arduino_Mega    Blue_Pill(stm32f01C)
  __________________________________________________________________________
  VCC        |   5v            |     5v        |     5v
  GND        |   GND           |     GND       |     GND
  CSN        |   Pin10 SPI/SS  | Pin10 SPI/SS  |     A4 NSS1 (PA4) 3.3v
  CE         |   Pin9          | Pin9          |     B0 digital (PB0) 3.3v
  SCK        |   Pin13         | Pin52         |     A5 SCK1   (PA5) 3.3v
  MISO       |   Pin11 (MOSI)  | Pin50         |     A7 MISI1  (PA7) 3.3v
  MOSI       |   Pin12 (MOS0)  | Pin51         |     A6 MOSO1  (PA6) 3.3v

  NOTE: MOSI is flipped with MISO

 DHT22 data  pin to arduino pin2
 DHT22 VCC to 5V on Arduino
 DHT22 GND to GND on Arduino
 */

#define uploadTimestamp "2021-04-14 05:27:58"

struct WeatherType {
    short temperature;           // 2 bytes
    short temperature_decimal;   // 2 bytes
    short humidity;              // 2 bytes
    short humidity_decimal;      // 2 bytes
    byte id;                     // 1 byte
    // Total 9, you can have max 32 bytes here
};

// instantiate an object for the nRF24L01 transceiver
RF24 radio(7, 8); // using pin 7 for the CE pin, and pin 8 for the CSN pin
DHT dht(2, DHT22);

WeatherType myDataTx;

const uint64_t writePipe = 0xE6E6E6E6E6E6;
const uint64_t readPipe = 0xB3B4B5B601;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial);
  Serial.println("RF24 transmitter setup.");

  /* radio.setChannel(104); */

  // to use ACK payloads, we need to enable dynamic payload lengths (for all nodes)
  //radio.enableDynamicPayloads();    // ACK payloads are dynamically sized

  // Acknowledgement packets have no payloads by default. We need to enable
  // this feature for all nodes (TX & RX) to use ACK payloads.
  //radio.enableAckPayload();
  /* radio.printDetails(); */
  dht.begin();

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
  Serial.println("RF24 transmitter setup complete.");
}

void loop() {
    float temperature = dht.readTemperature(true);
    float humidity = dht.readHumidity();

    if (isnan(humidity) || isnan(temperature)) {
      Serial.println("Failed to read from DHT sensor!");
      /* delay(2000); */
      temperature = 0.0;
      humidity = 0.0;
      /* return; */
    }
    Serial.print("Actual Temperature: ");
    Serial.println(temperature);
    digitalWrite(LED_BUILTIN, LOW);
    myDataTx.id = 'C';
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
     /* radio.print_status(radio.get_status()); */
     /* Serial.print("  Status: "); */
     /* Serial.println(radio.get_status()); */
   } else {
     Serial.println("Transmitting data below......");
     /* radio.printDetails(); */
     /* radio.print_status(radio.get_status()); */
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
    digitalWrite(LED_BUILTIN, HIGH);
    delay(10000);
}
