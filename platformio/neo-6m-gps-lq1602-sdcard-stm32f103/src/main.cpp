#include <TinyGPS++.h>
#include <SD.h>
#include <ArduinoJson.h>
#include <LiquidCrystal_I2C.h>
#include "config.h"

/*
FTDI | stm32f103
================
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V or (5V to 5V)

stm32f103 | NEO-6M
==================
GND       | GND
5V        | 5V
PC3 (RX2) | TX
PC2 (TX2) | RX

sd card | stm32f103
===================
GND     | GND
5V      | 5V
CS      | PA4
SCK     | PA5
MISO    | PA6
MOSI    | PA7

note: the NEO-6M Red LED will blink when it is connecting to a sattilite

*/

/* testing needs to be done as of 4/17/2021 */

const int cableSelectPin = PA4;
const int ledPin = PC13;
String outputFilename = "/gps-data.json";

TinyGPSPlus gps;
File fileHandle;
String fileName = "/gps-data.json";
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

void loop() {
    while (gpsSerial.available() > 0) {
    if (gps.encode(gpsSerial.read())) {
      StaticJsonDocument<300> jsonStructure;
      fileHandle = SD.open(fileName, FILE_WRITE);
      if (fileHandle) {
        Serial.println("file is open for writting...");
      } else {
        Serial.println("something went wrong with the file opening process.");
        while(true);
      }
      if( gps.location.isValid() ) {
        jsonStructure["latitude"] = String(gps.location.lat(), 6);
        jsonStructure["longitude"] = String(gps.location.lng(), 6);
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("lon and lat updated.");
      } else {
        jsonStructure["latitude"] = "";
        jsonStructure["longitude"] = "";
        lcd.clear();
        lcd.setCursor(0, 0);
        lcd.print("lon and lat NOT updated.");
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
        Serial.println("cannot write to file");
      }

      fileHandle.close();
      delay(500);
    }
  }
}

// method seems to be broken and is not being called as of 4/17/2021
void displayInfo() {
    StaticJsonDocument<400> jsonStructure;
    String time = "";

    fileHandle = SD.open("/gps-data.txt", FILE_WRITE);
    if (fileHandle) {
      Serial.println("file is open for writting...");
    } else {
      Serial.println("something went wrong with the file opening process.");
      while(true);
    }
  if( gps.location.isValid() ) {
    jsonStructure["latitude"] = String(gps.location.lat(), 6);
    jsonStructure["longitude"] = String(gps.location.lng(), 6);
    Serial.println("found lon and lat.");
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("found lon and lat");
  } else {
    jsonStructure["latitude"] = "";
    jsonStructure["longitude"] = "";
    Serial.println("Location data is not vaild from the gps.");
    digitalWrite(ledPin, HIGH);
    delay(200);
    digitalWrite(ledPin, LOW);
    delay(200);
    digitalWrite(ledPin, HIGH);
    delay(200);
    digitalWrite(ledPin, LOW);
    delay(200);
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
    Serial.println("Date data is not vaild from the gps.");
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
    Serial.println("Time data is not vaild from the gps.");
  }

  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);
  lcd.clear();
  lcd.setCursor(15, 0);
  for( int positionCounter1 = 0; positionCounter1 < payload.length(); positionCounter1++ ) {
    lcd.scrollDisplayLeft();  //Scrolls the contents of the display one space to the left.
    lcd.print(payload[positionCounter1]);  // Print 12 character array
    delay(250);
  }
  /* lcd.setCursor(0,0); */
  /* lcd.scrollDisplayLeft();  //Scrolls the contents of the display one space to the left. */
  /* lcd.print(payload); */

  if( fileHandle ) {
    fileHandle.println(payload);
  } else {
    Serial.println("cannot write to file");
  }

  fileHandle.close();
  Serial.println();
  delay(5000);
}
