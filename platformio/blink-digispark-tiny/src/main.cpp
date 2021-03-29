#include <Arduino.h>
/* #include <SoftwareSerial.h> */
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

void loop() {
  Serial.println("Hello from attiny85");
  digitalWrite(1, HIGH);
  delay(1000);
  digitalWrite(1, LOW);
  delay(1000);
}
