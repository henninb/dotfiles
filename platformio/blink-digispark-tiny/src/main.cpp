#include <Arduino.h>
/* #include <SoftwareSerial.h> */
#include <TinyWireM.h>
#include <ATtinySerialOut.h>
// ***
// *** Define the RX and TX pins. Choose any two
// *** pins that are unused. Try to avoid D0 (pin 5)
// *** and D2 (pin 7) if you plan to use I2C.
// ***
#define RX    3   // *** D3, Pin 2
#define TX    4   // *** D4, Pin 3


/* SoftwareSerial Serial(RX, TX); */

/*
 FTDI    | attiny85
 5V      | 5V
 GND     | GND
 RX      | TX (PB3)
 TX      | RX (PB4)
 DTR     | Reset (PB5)
 */

#define DEBUG 1
void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  pinMode(1, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello from attiny85");
  digitalWrite(1, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait for a second
  digitalWrite(1, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
