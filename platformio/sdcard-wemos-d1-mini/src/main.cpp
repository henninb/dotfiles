#include <SD.h>
#include <ArduinoJson.h>
#include "config.h"

/*

sdcard reader| wemos-d1-mini
  _____________________________
  VCC        |   5v
  GND        |   GND
  CSN        |   D4 (SS)
  SCK        |   D5
  MISO       |   D6
  MOSI       |   D7

*/

const int cableSelectPin = D4;
String fileName = "/filename.json";
File fileHandler;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  if( SD.begin(cableSelectPin) ) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    return;
  }

  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
}

void loop() {
  String milli = String(millis()/1000);

  fileHandler = SD.open(fileName, FILE_WRITE);

  if (fileHandler) {
    Serial.println("Writing to file...");

    StaticJsonDocument<100> jsonStructure;
    jsonStructure["millis"] = milli;
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

  fileHandler = SD.open(fileName);
  if (fileHandler) {
    Serial.println("Read:");
    // Reading the whole file
    while (fileHandler.available()) {
      Serial.write(fileHandler.read());
    }
    fileHandler.close();
  } else {
    Serial.println("error opening file.");
  }
  return;
}
