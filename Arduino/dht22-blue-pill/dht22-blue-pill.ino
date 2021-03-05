/*
 * Use STM32 "blue pill" board to read a DHT22 temperature and humidity sensor
 * (and wink a LED.)
 *
 * https://www.hackster.io/VE1DX/use-an-stm32f103c8t6-blue-pill-with-the-arduino-ide-11bd1c
 *
 */

#include <DHT.h>   // Adafruit Unified Sensor version 1.3.8

#define DHTPIN PA1  // Physical pin 11

#define DHTTYPE DHT22

//int dhtPin = PA8;  // Physical pin 29

DHT dht(DHTPIN, DHTTYPE);  // Initilize object dht for class DHT
                           // with DHT pin with STM32 and DHT type as DHT22

void setup() {
  //pinMode(DHTPIN, OUTPUT);
  Serial.begin(9600);
  dht.begin();          // Initialize DHT22 to read Temperature and humidity values.
  //pinMode(PC13, OUTPUT);
  delay(3000);          // Wait 3 seconds for it to stabilize
}


void loop() {
    // Wait a few seconds between measurements.
  delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius
  float c = dht.readTemperature();
  
  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(c)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  Serial.print("Humidity: "); 
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperature: "); 
  Serial.print(c * 1.8 + 32);
  Serial.println(" *F ");

  //digitalWrite(PC13, HIGH);
  //delay(1000);
  //digitalWrite(PC13, LOW);
}
