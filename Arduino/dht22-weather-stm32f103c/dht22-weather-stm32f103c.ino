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
  float humidity = dht.readHumidity();
  // Read temperature as Celsius
  float temperature = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  Serial.print("Humidity: ");
  Serial.print(humidity);
  Serial.print(" %\t");
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" *F ");

}
