#include <SparkFunBME280.h>

/*
 - SCL
 - SDA

I2C1
SDA – PB7 or PB9
SCL – PB6 or PB8

I2C2
SDA – PB11
SCL – PB10

  5V to 5V ??
  GND to GND
*/

/* need to set the below */
const int sclPin = 1;
const int sdaPin = 2;

BME280 bme280;

void setup() {
  Serial.begin(9600);
  while (!Serial);
  Serial.println("setup");
  //Wire.begin(sdaPin, sclPin);
  bme280.settings.commInterface = I2C_MODE;
  bme280.settings.I2CAddress = 0x76;
  bme280.settings.runMode = 3; //Normal mode
  bme280.settings.tStandby = 0;
  bme280.settings.filter = 0;
  bme280.settings.tempOverSample = 1;
  bme280.settings.pressOverSample = 1;
  bme280.settings.humidOverSample = 1;
  delay(10);  //Make sure sensor had enough time to turn on. BME280 requires 2ms to start up.
  bme280.begin();
  delay(10);
  Serial.println("setup completed...");
}

void loop() {
  // Wait a few seconds between measurements.
  delay(2000);

  float humidity = bme280.readFloatHumidity();
  /* float celsius = bme280.readTempC(); */
  /* float farenheit = bme280.readTempF(); */
  float temperature = bme280.readTempF();

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from bme280 sensor!");
    return;
  }

  Serial.print("Humidity: ");
  Serial.print(humidity);
  Serial.print(" %\t");
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" *F ");

}

