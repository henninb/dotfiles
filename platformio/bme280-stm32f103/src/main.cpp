#include <SparkFunBME280.h>
#include <ArduinoJson.h>

/*
   BME280 | STM32F103
   ==================
   SCL    | SCL (PB6)
   SDA    | SDA (PB7)
    5V    | 5V
   GND    | GND
*/

/* need to set the below */
const int sclPin = 1;
const int sdaPin = 2;

BME280 bme;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup");
  //Wire.begin(sdaPin, sclPin);
  bme.settings.commInterface = I2C_MODE;
  bme.settings.I2CAddress = 0x76;
  bme.settings.runMode = 3; //Normal mode
  bme.settings.tStandby = 0;
  bme.settings.filter = 0;
  bme.settings.tempOverSample = 1;
  bme.settings.pressOverSample = 1;
  bme.settings.humidOverSample = 1;
  delay(10);  //Make sure sensor had enough time to turn on. BME280 requires 2ms to start up.
  if(! bme.begin() ) {
    Serial.println("Could not find a valid BME280 sensor, check wiring!");
    while (1);
  }
  delay(10);
  Serial.println("setup completed...");
}

void loop() {
    // Wait a few seconds between measurements.
  delay(2000);

  float humidity = bme.readFloatHumidity();
  /* float celsius = bme.readTempC(); */
  float farenheit = bme.readTempF();
  float pressure = bme.readFloatPressure() / 100.0F;

  if (isnan(humidity) || isnan(farenheit)) {
    Serial.println("Failed to read from bme sensor!");
    return;
  }

  StaticJsonDocument<150> jsonStructure;
  jsonStructure["humidity"] = humidity;
  jsonStructure["temperature"] = farenheit;
  jsonStructure["pressure"] = pressure;
  String payload;
  serializeJson(jsonStructure, payload);
  Serial.print("Payload: ");
  Serial.println(payload);

  /* Serial.println(" hPa"); */
}
