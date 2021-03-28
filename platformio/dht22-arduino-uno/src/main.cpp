#include <Arduino.h>
#include <DHT.h>
#include <ArduinoJson.h>


/*
  5V to 5V
  GND to GND
  Data to Pin 2
*/

DHT dht(2, DHT22);

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
  float temperature = dht.readTemperature(true);

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  StaticJsonDocument<100> jsonStructure;
  jsonStructure["humidity"] = humidity;
  jsonStructure["temperature"] = temperature;
  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);


  /* Serial.print("Humidity: "); */
  /* Serial.print(humidity); */
  /* Serial.print(" %\t"); */
  /* Serial.print("Temperature: "); */
  /* Serial.print(temperature); */
  /* Serial.println(" *F "); */

}
