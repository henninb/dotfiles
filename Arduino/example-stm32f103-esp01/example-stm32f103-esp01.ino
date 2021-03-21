//Interfacing ESP8266 Wi-Fi with STM32F103C8
/*
FTDI | stm32f103
RX   | TX1 (PC9)
TX   | RX1 (PC10)
GND  | GND
3.3V | 3.3V

stm32f103 | ESP01
GND       | GND
3.3V      | 3.3V
3.3V      | CH-PD
PC3 (RX2) | TX
PC2 (TX2) | RX

1000uF capacitor between power and ground (to prevent power issues)

Connect to DHT22 to 3.3V or 5V rail and Pin PA1 of the stm32f103

*/

#include <DHT.h>

#define DEBUG 1

DHT dht(PA1, DHT22);

char incomingByte = 0;
char message[100] = {0};
int idx = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial);
#ifdef DEBUG
  Serial.println("setup started...");
#endif
  Serial2.begin(9600);   //begins serial communication with esp8266 with baud rate 9600 (Change according to your esp8266 module)
  while (!Serial2);
  dht.begin();
  delay(3000);          // Wait 3 seconds for it to stabilize the dht22
#ifdef DEBUG
  Serial.println("setup completed...");
#endif
}

void loop() {
  /* delay(2000); */
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature(true);

  if (isnan(humidity) || isnan(temperature)) {
#ifdef DEBUG
    Serial.println("Failed to read from DHT sensor!");
#endif
    return;
  }

  if (Serial2.available() > 0) {
    incomingByte = (char) Serial2.read();
    if( incomingByte == '\n' ) {
      idx = 0;
      if( strlen(message) > 0 ) {
#ifdef DEBUG
        Serial.print("message: ");
        Serial.println(message);
#endif
      }
      if( strncmp(message, "start", 5) == 0 ) {
        Serial2.println(temperature);
      }
      memset(message, '\0', sizeof(message));
    } else {
      message[idx] = incomingByte;
      idx++;
    }
  } else {
  }
}
