#include <Arduino.h>
#include <SoftSerial.h>

#ifdef __AVR__
  #include <avr/power.h>
#endif

/* serial monitor not built in by default
 * requires an external monitor */
/* #define DEBUG_TX_RX_PIN 2 */
#define RX    3
#define TX    4
/* SoftSerial mySerial(DEBUG_TX_RX_PIN, DEBUG_TX_RX_PIN, true); */
SoftSerial mySerial(RX, TX);

#define DEBUG 1
void setup() {
  mySerial.begin(9600);
  /* while( !mySerial); */
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
