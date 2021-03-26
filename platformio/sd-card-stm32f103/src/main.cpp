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

stm32f103 | NEO-6M
GND       | GND
3.3V      | 3.3V
3.3V      | CH-PD
PC3 (RX2) | TX
PC2 (TX2) | RX

SD CS = PA4
SD SCK = PA5
SD MISO = PA6
SD MOSI = PA7

 */

Sd2Card card;
SdVolume volume;
SdFile root;

// change this to match your SD shield or module;
// Arduino Ethernet shield: pin 4
// Adafruit SD shields and modules: pin 10
// Sparkfun SD shield: pin 8
const int chipSelect = PA4;
const int pinCS = 1;

void setup() {
  Serial.begin(9600);
  pinMode(pinCS, OUTPUT);

  // SD Card Initialization
  if (SD.begin()) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    return;
  }

  // Create/Open file
  File myFile = SD.open("gps-data.txt", FILE_WRITE);

  // if the file opened okay, write to it:
  if (myFile) {
    Serial.println("Writing to file...");
    // Write to file
    myFile.println("Testing text 1, 2 ,3...");
    myFile.close(); // close the file
    Serial.println("Done.");
  } else {
    Serial.println("error opening test.txt");
  }
  // Reading the file
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
