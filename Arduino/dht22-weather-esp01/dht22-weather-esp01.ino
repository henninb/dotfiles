#include <DHT.h>   // Adafruit Unified Sensor version 1.3.8

#define DHTPIN 2

#define DHTTYPE DHT22

//int dhtPin = PA8;  // Physical pin 29

DHT dht(DHTPIN, DHTTYPE);  // Initilize object dht for class DHT
                           // with DHT pin with STM32 and DHT type as DHT22

void setup() {
  //pinMode(DHTPIN, OUTPUT);
  Serial.begin(9600);
  dht.begin();          // Initialize DHT22 to read Temperature and humidity values.
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
  /* Serial.print(c * 1.8 + 32); */
  Serial.println(" *F ");
}
