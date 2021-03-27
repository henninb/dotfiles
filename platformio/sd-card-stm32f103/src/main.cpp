#include <Arduino.h>
#include <SD.h>
#include <Wire.h>
#include <SPI.h>

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

/* Sd2Card card; */
/* SdVolume volume; */
/* SdFile root; */

/* const int chipSelect = PA4; */
const int pinCS = PA4;

void setup() {
  Serial.begin(9600);
  pinMode(pinCS, OUTPUT);

  // SD Card Initialization
  if (SD.begin()) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    return;
  }

  // Create/Open file
  File myFile = SD.open("gps-data.txt", FILE_WRITE);

  // if the file opened okay, write to it:
  if (myFile) {
    Serial.println("Writing to file...");
    myFile.println("Testing text 1, 2 ,3...");
    myFile.close();
    Serial.println("Done.");
  } else {
    Serial.println("error opening test.txt");
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
    Serial.println("error opening test.txt");
  }
}

void loop() {
  return;
}
