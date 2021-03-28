/* #include <Arduino.h> */
#include <SD.h>
#include <ArduinoJson.h>
/* #include <Wire.h> */
/* #include <SPI.h> */

/*
FTDI | stm32f103
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V

sd card | stm32f103
GND     | GND
5V      | 5V
CS      | PA4
SCK     | PA5
MISO    | PA6
MOSI    | PA7

*/

/* const int chipSelect = PA4; */
const int pinCS = PA4;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  if (SD.begin(pinCS)) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    return;
  }

  // Create/Open file
  File myFile = SD.open("gps-data.txt", FILE_WRITE);

  // if the file opened okay, write to it:
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

    /* myFile.println("Testing text 1, 2 ,3..."); */
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
}

void loop() {
  return;
}
