#include <TinyGPS++.h>
#include <SD.h>
#include <ArduinoJson.h>

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
3.3V      | 3.3V
3.3V      | CH-PD
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

#define uploadTimestamp "2021-04-14 05:27:58"

const int cableSelectPin = PA4;
const int ledPin = PC13;

void displayInfo();

TinyGPSPlus gps;
File fileHandle;

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
  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete.");
}

void loop() {
  while (gpsSerial.available() > 0)
    if (gps.encode(gpsSerial.read())) {
      displayInfo();
    }

  // If 5000 milliseconds pass and there are no characters coming in
  // over the software serial port, show a "No GPS detected" error
  if (millis() > 5000 && gps.charsProcessed() < 10) {
    Serial.println("No GPS detected");
    while(true);
  }
}

void displayInfo() {
    StaticJsonDocument<250> jsonStructure;
    /* String date = ""; */
    String time = "";

    fileHandle = SD.open("/gps-data.txt", FILE_WRITE);
    if (fileHandle) {
      Serial.println("file is open for writting...");
    } else {
      Serial.println("something went wrong with the file opening process.");
      while(true);
    }
  if (gps.location.isValid()) {
  /* if (true) { */
    digitalWrite(ledPin, HIGH);
    delay(1000);
    digitalWrite(ledPin, LOW);
    delay(1000);
    jsonStructure["latitude"] = String(gps.location.lat(), 6);
    jsonStructure["longitude"] = String(gps.location.lng(), 6);
    Serial.println("found long and lat.");
  } else {
    Serial.println("Location data is not vaild from the gps.");
    digitalWrite(ledPin, HIGH);
    delay(250);
    digitalWrite(ledPin, LOW);
    delay(250);
    digitalWrite(ledPin, HIGH);
    delay(250);
    digitalWrite(ledPin, LOW);
    delay(250);
  }

  if (gps.date.isValid()) {
    int month = gps.date.month();
    int day = gps.date.day();
    int year = gps.date.year();
    char now[20] = {0};

    sprintf(now, "%04d-%02d-%02d", year, month, day);

    /* date = String(gps.date.year()) + "-"; */
    /* date = date + String(gps.date.month()) + "-"; */
    /* date = date + String(gps.date.day()); */
    jsonStructure["date"] = now;
  } else {
    Serial.println("Date data is not vaild from the gps.");
  }

  if (gps.time.isValid()) {
    int hour = gps.time.hour();
    int min = gps.time.minute();
    int sec = gps.time.second();

    char now[20] = {0};

    sprintf(now, "%02d:%02d:%02d", hour, min, sec);
    /* time = "" + String(gps.time.hour()) + ":"; */
    /* time = time + String(gps.time.minute()) + ":"; */
    /* time = time + String(gps.time.second()); */
    jsonStructure["time"] = now;
  } else {
    Serial.println("Time data is not vaild from the gps.");
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
  Serial.println();
  delay(5000);
}
