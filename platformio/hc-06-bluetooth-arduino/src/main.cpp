#include <Arduino.h>

/*
Arduino Pins           Bluetooth Pins
RX (Pin 0)     ———->    TX
TX (Pin 1)      ———->   RX
5V                ———-> VCC
GND             ———->   GND
 */

#define uploadTimestamp "2021-04-14 05:27:58"
#define DEBUG 1

char incoming_value = 0;

void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
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
