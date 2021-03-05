#include <DHT.h>

#define DHTPIN 2     // what pin we're connected to
#define DHTTYPE DHT22   // DHT 22  (AM2302)

int maxHum = 60;
int maxTemp = 40;

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  //pinMode(fan, OUTPUT);
  Serial.begin(9600); 
  dht.begin();
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
  
 // if(h > maxHum || t > maxTemp) {
 //     digitalWrite(fan, HIGH);
 // } else {
 //    digitalWrite(fan, LOW); 
 // }
  
  Serial.print("Humidity: "); 
  Serial.print(h);
  Serial.print(" %\t");
  Serial.print("Temperature: "); 
  Serial.print(c * 1.8 + 32);
  Serial.println(" *F ");

}
