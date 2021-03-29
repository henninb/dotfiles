#include <Arduino.h>
#include <SoftwareSerial.h>

const int Rx = 3; // this is physical pin 2

const int Tx = 4; // this is physical pin 3

SoftwareSerial mySerial(Rx, Tx);
/*
 Arduino    | attiny85
 5V      | 5V
 GND     | GND
 RX      | TX (PB3)
 TX      | RX (PB4)
 DTR     | Reset (PB5)
 */

#define DEBUG 1
void setup() {
  mySerial.begin(9600);
  while( !mySerial);
#ifdef DEBUG
  mySerial.println("setup started...");
#endif

  pinMode(0, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  mySerial.println("setup completed...");
#endif
}

// the loop function runs over and over again forever
void loop() {
  mySerial.println("Hello from attiny85");
  digitalWrite(0, HIGH);
  delay(250);
  digitalWrite(0, LOW);
  delay(250);
}
