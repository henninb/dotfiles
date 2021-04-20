#include <TinyGPS++.h>
#include <SD.h>
#include <ArduinoJson.h>
#include <LiquidCrystal_I2C.h>
#include "config.h"

/*
FTDI | stm32f103
================
RX   | TX1 PA9
TX   | RX1 PA10
GND  | GND
3.3V | 3.3V or (5V to 5V)

stm32f103 | NEO-6M
==================
GND       | GND
5V        | 5V
PA3 (RX2) | TX
PA2 (TX2) | RX

sd card | stm32f103
===================
GND     | GND
5V      | 5V
CS      | PA4
SCK     | PA5
MISO    | PA6
MOSI    | PA7

note: the NEO-6M Red LED will blink when it is connecting to a sattilite

stm32f103 | lcd
===============
SDA1 PB7  | SDA
SCL1 PB6  | SCL
GND       | GND
5V        | VCC

*/

/* testing needs to be done as of 4/17/2021 */

const int cableSelectPin = PA4;
const int ledPin = PC13;
String fileName = "/file.dat"; // fileName must be 8.3?

TinyGPSPlus gps;
File fileHandle;
LiquidCrystal_I2C lcd(PCF8574A_ADDR_A21_A11_A01, 4, 5, 6, 16, 11, 12, 13, 14, POSITIVE); //0x3f
HardwareSerial gpsSerial(USART2);   // or HardWareSerial Serial2 (PA3, PA2);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  pinMode(ledPin,OUTPUT);

  if (SD.begin(cableSelectPin)) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    while(true);
  }

  gpsSerial.begin(9600);
  while (!gpsSerial);
  Serial.println("gps is ready to use.");

  lcd.begin(16,2);
  delay(500);
  lcd.setCursor(0, 0);
  lcd.clear();
  Serial.println("lcd is ready to use.");
  delay(2000);

  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
  lcd.print("setup completed.");
  delay(250);
}

//TODO: combine date and time into timestamp
void loop() {
    String milli = String(millis()/1000);
    while (gpsSerial.available() > 0) {
    if (gps.encode(gpsSerial.read())) {
      StaticJsonDocument<300> jsonStructure;
      fileHandle = SD.open(fileName.c_str(), FILE_WRITE);
      if( !fileHandle ) {
        Serial.println("something went wrong with the file opening process.");
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("file open failed.");
        delay(250);
      }
      if( gps.location.isValid() ) {
        jsonStructure["latitude"] = String(gps.location.lat(), 6);
        jsonStructure["longitude"] = String(gps.location.lng(), 6);
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print(String(gps.location.lat(), 6));
        lcd.setCursor(0, 1);
        lcd.print(String(gps.location.lng(), 6));
        delay(250);
      } else {
        jsonStructure["latitude"] = "";
        jsonStructure["longitude"] = "";
        lcd.clear();
        lcd.setCursor(0, 0);
        milli = String(millis()/1000);
        lcd.print("no gps data: " + milli);
        delay(500);
      }
      if( gps.date.isValid() ) {
        int month = gps.date.month();
        int day = gps.date.day();
        int year = gps.date.year();
        char now[20] = {0};
        sprintf(now, "%04d-%02d-%02d", year, month, day);
        jsonStructure["date"] = now;
      } else {
        jsonStructure["date"] = "";
      }
      if( gps.time.isValid() ) {
        int hour = gps.time.hour();
        int min = gps.time.minute();
        int sec = gps.time.second();
        char now[20] = {0};
        sprintf(now, "%02d:%02d:%02d", hour, min, sec);
        jsonStructure["time"] = now;
      } else {
        jsonStructure["time"] = "";
      }
      String payload;
      serializeJson(jsonStructure, payload);
      Serial.print("Payload: ");
      Serial.println(payload);

      if( fileHandle ) {
        fileHandle.println(payload);
      } else {
        Serial.println("cannot write file");
      }

      fileHandle.close();
      delay(2000);
    }
  }
}
