#include <Arduino.h>
#include <LowPower.h>

#define uploadTimestamp "2021-04-14 05:27:58"
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
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed...");
#endif
}

void loop() {
  Serial.println("Hello from Arduino Nano");
  Serial.println("Arduino:- I am going for a Nap");
  delay(1000);
  digitalWrite(LED_BUILTIN,LOW);
  for( unsigned int idx = 0; idx < 8; idx++ ) {
    LowPower.idle(SLEEP_8S, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART0_OFF, TWI_OFF);
  }

  Serial.println("Arduino:- Hey I just Woke up");
  Serial.println("");
  delay(2000);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
