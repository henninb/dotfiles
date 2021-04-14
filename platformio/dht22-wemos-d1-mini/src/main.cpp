#include <DHT.h>
#include <ArduinoJson.h>

#define uploadTimestamp "2021-04-14 05:27:58"

#define DHTPIN 2

DHT dht(2, DHT22);

void setup() {
  //pinMode(DHTPIN, OUTPUT);
  Serial.begin(9600);
  dht.begin();          // Initialize DHT22 to read Temperature and humidity values.
  delay(3000);          // Wait 3 seconds for it to stabilize
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete");
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

  StaticJsonDocument<100> jsonStructure;
  jsonStructure["humidity"] = humidity;
  jsonStructure["temperature"] = temperature;
  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);
}
