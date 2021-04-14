#include <ESP8266WiFi.h>
#include <DHT.h>
#include <SparkFunBME280.h>
/* #include <Wire.h> */
#include "config.h"

/* void setLocation(); */
//for Wemos deepSleep -- connect D0 to the reset
//Reprogram as the ESP is sleeping, disconnect D0 - RST and try again

/*
 bme280  | wemos-d1-mini
 =======================
  SDA    | D2
  SCL    | D1
  5V     | 5V
  GND    | GND
 */

#define uploadTimestamp "2021-04-14 05:27:58"

//#define WIFI_DELAY 15000 //for testing
#define USE_SERIAL_PRINT_FLAG 1

const int ESP_DEEP_SLEEP = 600; //10 min
//const int ESP_DEEP_SLEEP = 10; //10 sec, for testing
/* const char* ssid = ""; */
/* const char* password = ""; */
const char* thingspeak_host = "api.thingspeak.com";
const char* sparkfun_host = "data.sparkfun.com";

String sparkfun_publicKey = "";
String sparkfun_privateKey = "";

String location = "default";

//https://thingspeak.com/channels/185740
String THINGSPEAK_API_KEY_LOWER_BATHROOM = ""; //Write API Key
//https://thingspeak.com/channels/185750
String THINGSPEAK_API_KEY_OFFICE = ""; //Write API Key
//https://thingspeak.com/channels/185752
String THINGSPEAK_API_KEY_MASTER_BEDROOM = ""; //Write API Key
//https://thingspeak.com/channels/185753
String THINGSPEAK_API_KEY_GARAGE = ""; //Write API Key

//String THINGSPEAK_API_KEY = String(THINGSPEAK_API_KEY_LOWER_BATHROOM);
String THINGSPEAK_API_KEY = "default";

//Global sensor object
BME280 bme280;
const int sclPin = D1;
const int sdaPin = D2;

void setup() {
 //setLocation("lower_bathroom");
 /* setLocation("office"); */

 pinMode(D0, WAKEUP_PULLUP);

#ifdef USE_SERIAL_PRINT_FLAG
  Serial.begin(115200);
  /* Serial.begin(9600); */
  while(!Serial);
#endif

#ifdef USE_SERIAL_PRINT_FLAG
  Serial.println("ESP8266 Connecting to " + String(ssid));
  Serial.print("Location: ");
  Serial.println(location);
  Serial.println("API Key: " + String(THINGSPEAK_API_KEY));
#endif
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(3000);
#ifdef USE_SERIAL_PRINT_FLAG
    Serial.print(".");
#endif
  }

#ifdef USE_SERIAL_PRINT_FLAG
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
#endif

  Wire.begin(sdaPin, sclPin);
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
  Serial.println("setup completed for the wemos d1 mini.");
}

void setLocation(String myLocation) {
  location = myLocation;

  if( myLocation == "office") {
    THINGSPEAK_API_KEY = THINGSPEAK_API_KEY_OFFICE;
  } else if (myLocation == "garage" ) {
    THINGSPEAK_API_KEY = THINGSPEAK_API_KEY_GARAGE;
  } else if (myLocation == "lower_bathroom" ) {
    THINGSPEAK_API_KEY = THINGSPEAK_API_KEY_LOWER_BATHROOM;
  } else if (myLocation == "master_bedroom" ) {
    THINGSPEAK_API_KEY = THINGSPEAK_API_KEY_MASTER_BEDROOM;
  } else {
    THINGSPEAK_API_KEY = "";
  }
}

void postSparkfunMetrics(const char *hostname, String privateKey, String publicKey, String farenheit, String humidity, String location) {
  WiFiClient wifiClient;
  String url;
  unsigned long timeout;
  String line;

  if( !wifiClient.connect(hostname, 80) ) {
#ifdef USE_SERIAL_PRINT_FLAG
    Serial.println("WARN: connection failed");
#endif
    return;
  }

  url = "/input/";
  url += sparkfun_publicKey;
  url += "?private_key=";
  url += sparkfun_privateKey;
  url += "&temp=";
  url += farenheit;
  url += "&humidity=";
  url += humidity;
  url += "&loc=";
  url += location;

  wifiClient.print(String("GET ") + url + " HTTP/1.1\r\n" + "Host: " + hostname + "\r\n" +   "Connection: close\r\n\r\n");
  delay(10);

  timeout = millis();
  while ( wifiClient.available() == 0 ) {
    if (millis() - timeout > 5000) {
#ifdef USE_SERIAL_PRINT_FLAG
      Serial.println("WARN: client Timeout on sparkfun.");
#endif
      wifiClient.stop();
      return;
    }
  }

  // Read all the lines of the reply from server and print them to Serial
  while( wifiClient.available() ) {
    line = wifiClient.readStringUntil('\r');
#ifdef USE_SERIAL_PRINT_FLAG
    Serial.print(line);
#endif
  }
}

void postThingspeakMetrics(const char *hostname, String api_key, String farenheit, String humidity) {
  WiFiClient wifiClient;
  String url;
  unsigned long timeout;
  String line;

  if( !wifiClient.connect(hostname, 80) ) {
#ifdef USE_SERIAL_PRINT_FLAG
    Serial.println("WARN: connection failed");
#endif
    return;
  }

  url = "/update?api_key=";
  url += api_key;
  url += "&field1=";
  url += String(farenheit);
  url += "&field2=";
  url += String(humidity);

  wifiClient.print(String("GET ") + url + " HTTP/1.1\r\n" + "Host: " + hostname + "\r\n" +   "Connection: close\r\n\r\n");
  delay(10);

  timeout = millis();
  while ( wifiClient.available() == 0 ) {
    if (millis() - timeout > 5000) {
#ifdef USE_SERIAL_PRINT_FLAG
      Serial.println("WARN: Client Timeout !");
#endif
      wifiClient.stop();
      return;
    }
  }

  // Read all the lines of the reply from server and print them to Serial
  while( wifiClient.available() ) {
    line = wifiClient.readStringUntil('\r');

  }
#ifdef USE_SERIAL_PRINT_FLAG
    //Serial.print(line);
    Serial.print("INFO: successful transactions.");
#endif
}

void loop() {
  float humidity = 0.0;
  float celsius = 0.0;
  float farenheit = 0.0;

  delay(3000); // 3 seconds

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)

  humidity = bme280.readFloatHumidity();
  celsius = bme280.readTempC();
  farenheit = bme280.readTempF();

  // Check if any reads failed and exit early (to try again).
  if (isnan(humidity) || isnan(celsius) || isnan(farenheit)) {
#ifdef USE_SERIAL_PRINT_FLAG
    Serial.println("WARN: failed to read from sensor!");
#endif
    return;
  }

#ifdef USE_SERIAL_PRINT_FLAG
  Serial.println("Humidity: " + String(humidity) + "\t" + "Celsius: " + String(celsius) + "\t" + "Farenheit: " + String(farenheit));
  //Serial.println("host: " + String(sparkfun_host));
#endif

  postThingspeakMetrics(thingspeak_host, THINGSPEAK_API_KEY, String(farenheit), String(humidity));
#ifdef USE_SERIAL_PRINT_FLAG
  Serial.println("\nINFO: thingspeak: closing connection for now.");
#endif
  //postSparkfunMetrics(sparkfun_host, sparkfun_privateKey, sparkfun_publicKey, String(farenheit), String(humidity), location);

//#ifdef USE_SERIAL_PRINT_FLAG
//  Serial.println("\nINFO: sparkfun: closing connection for now.");
//#endif

  ESP.deepSleep(ESP_DEEP_SLEEP * 1000000);
  //delay(WIFI_DELAY); //for testing only
}

