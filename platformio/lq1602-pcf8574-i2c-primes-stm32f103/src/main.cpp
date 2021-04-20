#include <Arduino.h>
#include <LiquidCrystal_I2C.h>
#include "config.h"

/*

stm32f103 | lcd
===============
SDA PB7   | SDA
SCL PB6   | SCL
GND       | GND
5V        | VCC

Note: no need for external power on the lcd display

*/

#define ledPin PC13

int isPrime( int );

/* LiquidCrystal_I2C lcd(CF8574_ADDR_A21_A11_A01, 4, 5, 6, 16, 11, 12, 13, 14, POSITIVE); //0x27 */
LiquidCrystal_I2C lcd(PCF8574A_ADDR_A21_A11_A01, 4, 5, 6, 16, 11, 12, 13, 14, POSITIVE); //0x3f

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup started...");
  pinMode(ledPin,OUTPUT);
  lcd.begin(16,2);
  delay(500);
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
