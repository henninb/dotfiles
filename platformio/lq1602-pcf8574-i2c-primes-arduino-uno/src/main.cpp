#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "config.h"

/*
  pcf8574 | arduino uno
  =====================
  5V      | 5V
  GND     | GND
  CLK     | 5 SCL
  DAT     | 4 SDA
*/

int isPrime( int );

/* LiquidCrystal_I2C lcd(0x3f, 16, 2); */
/* LiquidCrystal_I2C lcd(0x27, 16, 2); */
LiquidCrystal_I2C lcd(0x3f);

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);

  lcd.begin(16, 2);
  lcd.backlight();
  lcd.setCursor(0, 1);
  lcd.clear();
  Wire.begin();
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
}

void loop() {
  idx++;
  String counter = String(idx);
  lcd.setCursor(0, 1);

  if( isPrime(idx) == 1 ) {
    counter.concat(" is prime");
    lcd.clear();
    lcd.print(counter);
    Serial.println(counter);

    delay(5000);
  } else {
    counter.concat(" NOT prime");
    lcd.clear();
    lcd.print(counter);
    Serial.println(counter);
    delay(500);
  }
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
