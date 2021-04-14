#include <DHT.h>
#include <ArduinoJson.h>

/*
  dht | esp01-1m
  ==============
  5V  | 5V
  GND | GND
  Data| Pin 2
  requires an shared ground pin to handle the 5V requirement
*/

#define uploadTimestamp "2021-04-14 05:27:58"

#define dhtPin 2

DHT dht(2, DHT22);

void setup() {
  Serial.begin(115200);
  while(!Serial);
  Serial.println("setup");
  dht.begin();
  delay(3000);
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
