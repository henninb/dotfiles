#include <Arduino.h>
/* #include <TinyDebugSerial.h> */
#include <SoftSerial.h>

#ifdef __AVR__
  #include <avr/power.h>
#endif

#define DEBUG_TX_RX_PIN 2

SoftSerial mySerial(DEBUG_TX_RX_PIN, DEBUG_TX_RX_PIN, true);

/* #include <TinyWireM.h> */
/* #include <ATtinySerialOut.h> */
// ***
// *** Define the RX and TX pins. Choose any two
// *** pins that are unused. Try to avoid D0 (pin 5)
// *** and D2 (pin 7) if you plan to use I2C.
// ***
#define RX    3
#define TX    4


/* SoftwareSerial mySerial(RX, TX); */

#define DEBUG 1
void setup() {
  mySerial.begin(9600);
  while( !mySerial);
#ifdef DEBUG
  mySerial.println("setup started...");
#endif

  pinMode(1, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  mySerial.println("setup completed...");
#endif
}

void loop() {
  mySerial.println("Hello from attiny85 digispark");
  digitalWrite(1, HIGH);
  delay(1000);
  digitalWrite(1, LOW);
  delay(1000);
}
