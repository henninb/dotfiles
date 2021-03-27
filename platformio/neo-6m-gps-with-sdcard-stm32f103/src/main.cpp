#include <TinyGPS++.h>
#include <SoftwareSerial.h>
#include <SD.h>
#include <ArduinoJson.h>

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

sd card | stm32f103
GND     | GND
5V      | 5V
CS      | PA4
SCK     | PA5
MISO    | PA6
MOSI    | PA7
*/

const int csPin = PA4;
const int ledPin = PC13;

void displayInfo();

TinyGPSPlus gps;
File myFile;

HardwareSerial gpsSerial(USART2);   // or HardWareSerial Serial2 (PA3, PA2);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup...");

  pinMode(ledPin,OUTPUT);
  if (SD.begin(csPin)) {
    Serial.println("SD card is ready to use.");
  } else {
    Serial.println("SD card initialization failed");
    Serial.println("please be sure you have put an SD card in the slot.");
    Serial.println("please be sure to define the CS pin in the begin method.");
    while(true);
  }

  gpsSerial.begin(9600);
  while (!gpsSerial);
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
    StaticJsonDocument<100> jsonStructure;
    myFile = SD.open("gps-data.txt", FILE_WRITE);
    if (myFile) {
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
    /* String location = ""; */
    jsonStructure["latitude"] = String(gps.location.lat(), 6);
    jsonStructure["longitude"] = String(gps.location.lng(), 6);
    /* location = location + "Latitude: " + String(gps.location.lat(), 6) + " \r\n"; */
    /* location = location + "Longitude: " + String(gps.location.lng(), 6)"; */
    /* location = location + "Altitude: " + String(gps.altitude.meters(), 6); */
    Serial.println("found long and lat.");
    /* if( myFile ) { */
    /*   /1* myFile.println(location); *1/ */
    /* } else { */
    /*   Serial.println("cannot write to file"); */
    /* } */
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
    String date = "";
    date = String(gps.date.year()) + "-";
    date = date + String(gps.date.month()) + "-";
    date = date + String(gps.date.day());
    Serial.println(date);
    jsonStructure["date"] = date;
    /* if( myFile ) { */
    /*   myFile.println(date); */
    /* } else { */
    /*   Serial.println("cannot write to file"); */
    /* } */
  } else {
    Serial.println("Date data is not vaild from the gps.");
  }

  if (gps.time.isValid()) {
    String time = "";
    time = "" + String(gps.time.hour()) + ":";
    time = time + String(gps.time.minute()) + ":";
    time = time + String(gps.time.second());
    Serial.println(time);
    jsonStructure["time"] = time;
  }
  else {
    Serial.println("Time data is not vaild from the gps.");
  }

  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);

  if( myFile ) {
    myFile.println(payload);
  } else {
    Serial.println("cannot write to file");
  }

  myFile.close();
  Serial.println();
  delay(5000);
}
