/*
I2C

PCF8574 | attiny85
==================
SDA     | Pin PB0
SCL     | Pin PB2
5V      | 5V
GND     | GND

Note: no need for external power on the lcd display
Note: works at 16mHz

rtc     | attiny85
==================
SDA     | Pin PB0
SCL     | Pin PB2
5V      | 5V
GND     | GND
*/
#include <Arduino.h>
#include <LiquidCrystal_I2C.h>
#include <TinyWireM.h>
#include <RTClib.h>

RTC_DS1307 rtc;
LiquidCrystal_I2C lcd(0x3f, 16, 2);
/* LiquidCrystal_I2C lcd(0x27, 16, 2); */

void setup() {
  TinyWireM.begin();
  lcd.init();
  delay(500);
  lcd.backlight();
  lcd.setCursor(0, 0);
  lcd.clear();
  if (! rtc.begin()) {
    lcd.print("failed rtc");
    while (true);
  }
  lcd.print("rtc setup");
  delay(500);
  rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));//auto update from computer time
  lcd.print("rtc adjusted");
  //rtc.adjust(DateTime(2021, 4, 1, 5, 0, 0));// to set the time manualy
  delay(500);
}

void loop() {
  lcd.setCursor(0, 0);
  lcd.clear();
  DateTime now = rtc.now();
  String time = String(now.hour()) + ":" + String(now.minute()) + ":" + String(now.second());
  String date = String(now.year()) + "-" + String(now.month()) + "-" + String(now.day());
  /* Serial.println(date + " " + time); */
  lcd.print(date + " " + time);

  delay(2000);
}
