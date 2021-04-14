#include <SD.h>
#include <ArduinoJson.h>

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

#define uploadTimestamp "2021-04-14 05:27:58"

const int cableSelectPin = D4;

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

  File myFile = SD.open("/gps-data.txt", FILE_WRITE);

  if (myFile) {
    Serial.println("Writing to file...");

    StaticJsonDocument<100> jsonStructure;
    jsonStructure["humidity"] = 1.1;
    jsonStructure["temperature"] = 2.2;
    String payload;
    serializeJson(jsonStructure, payload);
    Serial.print("Payload: ");
    Serial.println(payload);
    myFile.println(payload);

    myFile.close();
    Serial.println("Done.");
  } else {
    Serial.println("error opening file");
  }
  myFile = SD.open("gps-data.txt");
  if (myFile) {
    Serial.println("Read:");
    // Reading the whole file
    while (myFile.available()) {
      Serial.write(myFile.read());
    }
    myFile.close();
  } else {
    Serial.println("error opening file.");
  }
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup completed.");
}

void loop() {
  return;
}
