#include <Arduino.h>

/*
Arduino Pins           Bluetooth Pins
RX (Pin 0)     ———->    TX
TX (Pin 1)      ———->   RX
5V                ———-> VCC
GND             ———->   GND
 */

char incoming_value = 0;

#define DEBUG 1
void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
  if(Serial.available() > 0) {
    incoming_value = Serial.read();
    Serial.println(incoming_value);
    if(incoming_value == '1') {
      digitalWrite(LED_BUILTIN, HIGH);
      Serial.println("one incoming_value.");
    } else if(incoming_value == '0') {
      digitalWrite(LED_BUILTIN, LOW);
      Serial.println("zero incoming_value.");
    } else {
      Serial.println("invalid incoming_value.");
    }
  }
}
