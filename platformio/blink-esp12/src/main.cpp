#include <ESP8266WiFi.h>
/*
  Operational Mode (6 wires)
  ESP12    | FTDI
  ===============
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  GPIO0    | DTR
  CHPD     | 3.3V
  *** Required 1000uF capacitor (between VCC and GND), shorter leg GND
  Optional RST - to button for resetting
*/

/*
  Programming Mode (7 wires)
  ESP12    | FTDI
  ===============
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  RST      | RTS
  GPIO0    | DTR
  CHPD     | 3.3V
  1000uF capacitor (between VCC and GND), shorter leg GND
*/

#define uploadTimestamp "2021-04-14 05:27:58"
#define DEBUG 1

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(LED_BUILTIN, OUTPUT);
  WiFi.mode(WIFI_STA);
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from ESP12");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
