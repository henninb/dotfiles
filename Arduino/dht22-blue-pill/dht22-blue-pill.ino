/*
 * Use STM32 "blue pill" board to read a DHT22 temperature and humidity sensor
 * (and wink a LED.)
 *
 * Paul M Dunphy VE1DX
 * April 2020
 * https://www.hackster.io/VE1DX/use-an-stm32f103c8t6-blue-pill-with-the-arduino-ide-11bd1c
 *
 */

#include <DHT.h>   // Adafruit Unified Sensor version 1.3.8

#define DHTPIN PA1  // Physical pin 11

#define DHTTYPE DHT22

int LEDpin = PA8;  // Physical pin 29

DHT dht(DHTPIN, DHTTYPE);  // Initilize object dht for class DHT
                           // with DHT pin with STM32 and DHT type as DHT22

void setup() {
  pinMode(LEDpin, OUTPUT);
  Serial.begin(9600);
  dht.begin();          // Initialize DHT22 to read Temperature and humidity values.
  delay(3000);          // Wait 3 seconds for it to stabilize
}


void loop() {

  int i;

  for (int i = 1; i <= 8; i++) {
    digitalWrite(LEDpin, HIGH);
    delay(250);
    digitalWrite(LEDpin, LOW);
    delay(250);
  }

  float h = dht.readHumidity();       // Get Humidity value
  float t = dht.readTemperature();    // Get Temperature value

  Serial.print(t,1);                  // Print to serial monitor screen
  Serial.print("      ");
  Serial.print(h,1);
  Serial.println();

  digitalWrite(LEDpin, LOW);
  delay(1000);
}
