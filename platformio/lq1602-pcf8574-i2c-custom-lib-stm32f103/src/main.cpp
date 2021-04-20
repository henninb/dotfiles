#include <Arduino.h>
#include "config.h"
#include "LiquidCrystal_I2C.h"

/*
 pcf8574 | stm32f103
 =======================
  SDA    | PB7
  SCL    | PB6
  5V     | 5V
  GND    | GND
  if power is external -- need to ensure the ground pin is shared.

  5V to stm32f103 5V pin
  GND to stm32f103 GND pin
 */

#define ledPin PC13

int isPrime( int );

/* LiquidCrystal_I2C lcd(0x27, 16, 2); */
LiquidCrystal_I2C lcd(0x3f, 16, 2);

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup started...");
  pinMode(ledPin,OUTPUT);
  lcd.begin();
  /* lcd.backlight(); */
  delay(500);
  lcd.setBacklight(HIGH);
  /* lcd.noBacklight(); */
  lcd.setCursor(0, 0);
  lcd.clear();
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed...");
}

void loop() {
  idx++;
  /* lcd.backlight(); */
  String message = String(idx);
  lcd.setCursor(0, 0);

  if( isPrime(idx) == 1 ) {
    message.concat(" is prime");
    lcd.clear();
    /* lcd.backlight(); */
    lcd.print(message);
    Serial.println(message);
  } else {
    message.concat(" NOT prime");
    lcd.clear();
    lcd.print(message);
    Serial.println(message);
  }
  /* lcd.noBacklight(); */
  digitalWrite(ledPin, HIGH);
  delay(2000);
  digitalWrite(ledPin, LOW);
  delay(2000);
}

int isPrime(int number) {
  int idx;
  for (idx=2; idx<number; idx++) {
    if (number % idx == 0 && idx != number) {
      return 0;
    }
  }
  return 1;
}
