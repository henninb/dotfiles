#include <SPI.h>
#include <RH_RF95.h>
#include "config.h"

/*

 RF95    | Arduino Uno | stm32f103
 ---------------------------------
 GND     | ??          | ??
 3.3V    | VCC         | 3.3
 DIO0    | 2           | B0 digital (PB0)
 NSS     | 10 (SS)     | A4 NSS1 (PA4) 3.3v
 SCK     | 13 (SCK)    | A5 SCK1   (PA5) 3.3v
 MISI    | 11 (MOSI)   | A7 MISI1  (PA7) 3.3v
 MISO    | 12 (MOS0)   | A6 MOSO1  (PA6) 3.3v

 */

#define RFM95_CS PA4
#define RFM95_RST 9
#define RFM95_INT PB0

// Change to 434.0 or other frequency, must match RX's freq!
#define RF95_FREQ 915.0

// Singleton instance of the radio driver
RH_RF95 rf95(RFM95_CS, RFM95_INT);

// Blinky on receipt
#define LED PC13

int consecutiveLoopCount = 0;

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(RFM95_RST, OUTPUT);
  digitalWrite(RFM95_RST, HIGH);

  while (!Serial);
  Serial.begin(9600);
  delay(100);

  Serial.println("LoRa RX");

  // manual reset
  digitalWrite(RFM95_RST, LOW);
  delay(10);
  digitalWrite(RFM95_RST, HIGH);
  delay(10);

  while (!rf95.init()) {
    Serial.println("LoRa radio init failed");
    while (1);
  }
  Serial.println("LoRa radio init OK!");

  // Defaults after init are 434.0MHz, modulation GFSK_Rb250Fd250, +13dbM
  if (!rf95.setFrequency(RF95_FREQ)) {
    Serial.println("setFrequency failed");
    while (1);
  }
  Serial.print("Set Freq to: ");
  Serial.println(RF95_FREQ);

  // Defaults after init are 434.0MHz, 13dBm, Bw = 125 kHz, Cr = 4/5, Sf = 128chips/symbol, CRC on

  // The default transmitter power is 13dBm, using PA_BOOST.
  // If you are using RFM95/96/97/98 modules which uses the PA_BOOST transmitter pin, then
  // you can set transmitter powers from 5 to 23 dBm:
  rf95.setTxPower(23, false);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed");
}

void loop() {
  while (rf95.available()) {
    consecutiveLoopCount = 0;
    // Should be a message for us now
    uint8_t buf[RH_RF95_MAX_MESSAGE_LEN];
    uint8_t len = sizeof(buf);

    if (rf95.recv(buf, &len)) {
      digitalWrite(LED, HIGH);
      RH_RF95::printBuffer("Received: ", buf, len);
      Serial.print("Received: ");
      Serial.println((char*)buf);
       Serial.print("RSSI: ");
      Serial.println(rf95.lastRssi(), DEC);

      // Send a reply
      /* uint8_t data[] = "And hello back to you"; */
      /* rf95.send(data, sizeof(data)); */
      /* rf95.waitPacketSent(); */
      /* Serial.println("Sent a reply"); */
      /* digitalWrite(LED, LOW); */
    } else {
      Serial.println("Receive failed");
    }
  }

  consecutiveLoopCount++;
  if( consecutiveLoopCount > 100 ) {
    Serial.println("INFO: Outer Loop count exceeded threshold of 1000.");
    delay(500);
    /* lcd.clear(); */
    /* lcd.print("Transmitter not sending data."); */
    /* scrollInFromRight(0, "No TX is sending data to this RX."); */
    consecutiveLoopCount = 0;
  }
}
