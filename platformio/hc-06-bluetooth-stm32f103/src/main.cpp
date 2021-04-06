#include <Arduino.h>

/*
stm32f103 Pins           Bluetooth Pins
RX2 (Pin PA3 or PA10)     ———->    TX
TX2 (Pin PA2 or PA9)       ———->   RX
5V                ———-> VCC
GND             ———->   GND
 */

HardwareSerial Serial2(USART2);   // or HardWareSerial Serial2 (PA3, PA2);

char incoming_value = 0;

#define DEBUG 1
void setup() {
  Serial.begin(9600);
  while( !Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif

  Serial2.begin(9600);   //begins serial communication with bluetooth at baud rate 9600
  while (!Serial2);

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  #ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
  if(Serial2.available() > 0) {
    incoming_value = Serial2.read();
    Serial.println(incoming_value);
    Serial2.println(incoming_value);
    if(incoming_value == '1') {
      digitalWrite(LED_BUILTIN, HIGH);
      Serial.println("one incoming_value.");
      Serial2.println("one incoming_value.");
    } else if(incoming_value == '0') {
      digitalWrite(LED_BUILTIN, LOW);
      Serial.println("zero incoming_value.");
      Serial2.println("zero incoming_value.");
    } else {
      Serial.println("invalid incoming_value.");
      Serial2.println("invalid incoming_value.");
    }
  } else {
    /* Serial2.println("here"); */
  }

}
