#include <RF24.h>
#include "config.h"

/*
NRF24L01(YL-105) | wemos-d1-mini
  _____________________________
  VCC            | 5v
  GND            | GND
  CSN            | D8 (SS)
  CE             | D2
  SCK            | D5
  MISO           | D7 (MOSI)
  MOSI           | D6 (MIS0)

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
/* #define CE_PIN   0 */
/* #define CSN_PIN 16 */

/* RF24 radio(CE_PIN, CSN_PIN); */
RF24 radio(D2, D8); // D2 = CE, D8 = CSN

WeatherType myDataTx;

const uint64_t writePipe = 0xE6E6E6E6E6E6;
const uint64_t readPipe = 0xB3B4B5B601;


void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {
    // some boards need to wait to ensure access to serial over USB
  }
  Serial.println("RF24 transmitter setup.");
  Serial.println(D0);
  Serial.println(D8);

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
    digitalWrite(LED_BUILTIN, LOW);
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
  /* digitalWrite(LED_BUILTIN, (millis() / 1000) % 2); */

      // Now listen for a response
    /* radio.startListening(); */

    /* // But we won't listen for long */
    /* unsigned long started_waiting_at = millis(); */

    /* // Loop here until we get indication that some data is ready for us to read (or we time out) */
    /* while (!radio.available()) { */
    /*     // Oh dear, no response received within our timescale */
    /*     if (millis() - started_waiting_at > 1000) { */
    /*         Serial.print("  TX: Got no reply "); */
    /*         delay(2000); */
    /*         return; */
    /*     } */
    /* } */
    /* radio.read(&myDataTx, sizeof(myDataTx)); */
    digitalWrite(LED_BUILTIN, HIGH);
    delay(10000);
}
