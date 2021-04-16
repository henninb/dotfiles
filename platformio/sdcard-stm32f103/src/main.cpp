#include <SD.h>
#include <ArduinoJson.h>
#include "config.h"

/*

FTDI | stm32f103
================
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V

sd card | stm32f103
===================
GND     | GND
5V      | 5V
CS      | PA4
SCK     | PA5
MISO    | PA6
MOSI    | PA7

*/

const int pinChipSelect = PA4;
String fileName = "file.json";
File fileHandler;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  if (SD.begin(pinChipSelect)) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    return;
  }

  delay(2000);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
}

void loop() {
  String milli = String(millis()/1000);
  Serial.println(milli);
  delay(1000);

  //write file
  fileHandler = SD.open(fileName, FILE_WRITE);
  if (fileHandler) {
    Serial.println("Writing to file...");

    StaticJsonDocument<100> jsonStructure;
    jsonStructure["millis"] = 1.1;
    String payload;
    serializeJson(jsonStructure, payload);
    Serial.print("Payload: ");
    Serial.println(payload);
    fileHandler.println(payload);
    fileHandler.close();
    Serial.println("Done.");
  } else {
    Serial.println("error opening file");
  }

  // read file
  fileHandler = SD.open(fileName);
  if (fileHandler) {
    Serial.println("File Read:");
    while (fileHandler.available()) {
      Serial.write(fileHandler.read());
    }
    fileHandler.close();
  } else {
    Serial.println("error opening file.");
  }
  return;
}
