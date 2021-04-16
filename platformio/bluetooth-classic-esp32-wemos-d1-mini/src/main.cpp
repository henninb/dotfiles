#include <Arduino.h>
#include <BluetoothSerial.h>
#include <esp_bt_main.h>
#include <esp_bt_device.h>
#include "config.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

/*
serial connection, programming mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
IO0 -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

serial connection, regular mode
ESP32 | FTDI
============
VCC -> 3.3V
GND -> GND
TXD -> TX (RX usually, but this board is wierd)
RXD -> RX (TX usually, but this board is wierd)

1000uf cap to smooth the power between 3.3V and ground on the FTDI
 */

BluetoothSerial SerialBT;

void printDeviceAddress();

void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);

  SerialBT.begin("ynot-01");
  printDeviceAddress();
  Serial.println("bluetooth classic setup completed");
  delay(2000);
  Serial.print("BUILTIN_LED: ");
  Serial.println(BUILTIN_LED);
  Serial.print("upload timestamp: ");
  Serial.println(uploadTimestamp);
  Serial.println("setup complete");
}

void loop() {
  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {
    Serial.write(SerialBT.read());
  }
  delay(20);

}

void printDeviceAddress() {
  const uint8_t* point = esp_bt_dev_get_address();

  for (int idx = 0; idx < 6; idx++) {
    char str[3];

    sprintf(str, "%02X", (int)point[idx]);
    Serial.println(str);
    if (idx < 5){
      Serial.print(":");
    }
  }
}
