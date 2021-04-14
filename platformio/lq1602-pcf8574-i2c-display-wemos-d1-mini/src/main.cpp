#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

/*
 pcf8574 | wemos-d1-mini
 =======================
  SDA    | D2
  SCL    | D1
  5V     | 5V
  GND    | GND
 */

#define uploadTimestamp "2021-04-14 05:27:58"

int isPrime( int );

/* LiquidCrystal_I2C lcd(CF8574_ADDR_A21_A11_A01, 4, 5, 6, 16, 11, 12, 13, 14, POSITIVE); //0x27 */
LiquidCrystal_I2C lcd(PCF8574A_ADDR_A21_A11_A01, 4, 5, 6, 16, 11, 12, 13, 14, POSITIVE); //0x3f

int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup started...");
  pinMode(LED_BUILTIN,OUTPUT);
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
  digitalWrite(LED_BUILTIN, HIGH);
  delay(2000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(2000);
}

int isPrime(int number) {
    int i;
    for (i=2; i<number; i++) {
        if (number % i == 0 && i != number) {
          return 0;
        }
    }
    return 1;
}
