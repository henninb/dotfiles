#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include "config.h"
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

WiFiClient espClient;
PubSubClient mqttClient(espClient);

void setup() {
  Serial.begin(115200);
  while (!Serial);

  pinMode(LED_BUILTIN, OUTPUT);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  mqttClient.setServer(mqttServer, 1883);
  if (mqttClient.connect("espClient")) {
    Serial.println("mqtt connected.");
  } else {
    Serial.println("mqtt connection failed.");
  }

  WiFi.mode(WIFI_STA);
  Serial.println("setup complete");
}

void loop() {
  Serial.println("Hello from ESP12");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);

  if (mqttClient.connected()) {
    mqttClient.publish("ynot", "message1", true);
    delay(10);
    mqttClient.publish("ynot", "message2", true);
    delay(10);
  }
}
