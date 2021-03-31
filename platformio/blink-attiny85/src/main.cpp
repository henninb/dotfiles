#include <Arduino.h>
#include <SoftwareSerial.h>

const int Rx = 3;
const int Tx = 4;

SoftwareSerial mySerial(Rx, Tx);
/*
 Programming

 Arduino | attiny85
 ==================
 5V            | 5V
 GND           | GND
 Pin 13 (SCK)  | Pin 2
 Pin 12 (MISO) | Pin 1
 Pin 11 (MOSI) | Pin 0
 Pin 10 (SS)   | Reset

 LED from ground to pin 0
 load arduino programmer software on the arduino
note: 10uF cap, negative to ground and positive to reset on the arduino


0.1uF ceramic cap between vcc and gnd of the tiny 85 It is required for proper operation.
 */

#define DEBUG 1
void setup() {
  Serial.begin(9600);
  while( !Serial);
  mySerial.begin(9600);
  while( !mySerial);
#ifdef DEBUG
  mySerial.println("setup started...");
  Serial.println("setup started...");
#endif

  pinMode(0, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  mySerial.println("setup completed...");
#endif
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello from attiny85");
  mySerial.println("Hello from attiny85");
  digitalWrite(0, HIGH);
  delay(250);
  digitalWrite(0, LOW);
  delay(250);
}
