#include <DHT.h>

#define USE_FAHRENHEIT true

/*
  5V to 5V
  GND to GND
  Data to Pin PA1
*/

DHT dht(PA1, DHT22);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  dht.begin();
}

void loop() {
  // Wait a few seconds between measurements.
  delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature(USE_FAHRENHEIT);

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
