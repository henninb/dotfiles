/*
Connect to DHT22 to 3.3V or 5V rail and Pin PA1 of the stm32f103
 */

#include <DHT.h>

#define USE_FAHRENHEIT true

DHT dht(PA1, DHT22);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  dht.begin();
  delay(3000);          // Wait 3 seconds for it to stabilize
}

void loop() {
    // Wait 2 seconds between measurements.
  delay(2000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature(USE_FAHRENHEIT);

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
