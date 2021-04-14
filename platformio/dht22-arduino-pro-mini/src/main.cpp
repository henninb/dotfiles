#include <Arduino.h>
#include <DHT.h>
#include <ArduinoJson.h>

/*
  dht | arduino pro mini
  ======================
  5V  | 5V
  GND | GND
  Data| Pin 2
*/

#define uploadTimestamp "2021-04-14 05:27:58"

DHT dht(2, DHT22);

void setup() {
  Serial.begin(9600);
  while (!Serial);
  dht.begin();
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete");
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
}
