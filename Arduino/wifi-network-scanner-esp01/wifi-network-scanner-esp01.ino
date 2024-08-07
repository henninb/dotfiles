#include <ESP8266WiFi.h>
#include <EEPROM.h>¬


#define RESET_EEPROM false

int addr_ssid = 0;         // ssid index
int addr_password = 20;    // password index

void setup() {
EEPROM.begin(512);
Serial.begin(9600);

  int numberOfNetworks = WiFi.scanNetworks();

  if ( RESET_EEPROM ) {
    for (int i = 0; i < 512; i++) {
      EEPROM.write(i, 0);
    }
    EEPROM.commit();
    delay(500);
  }

  for(int i =0; i<numberOfNetworks; i++){
      Serial.print("Network name: ");
      Serial.println(WiFi.SSID(i));
      Serial.print("Signal strength: ");
      Serial.println(WiFi.RSSI(i));
      Serial.println("-----------------------");
  }

  Serial.println("");
  Serial.print("Write WiFi SSID at address "); Serial.println(addr_ssid);
  Serial.print("");
  for (int i = 0; i < ssid.length(); ++i)
  {
    EEPROM.write(addr_ssid + i, ssid[i]);
    Serial.print(ssid[i]); Serial.print("");
  }


  // write to EEPROM.
  /* EEPROM.write(addr, 'a'); */
  /* addr++;                      //Increment address */
  /* EEPROM.write(addr, 'b'); */
  /* addr++;                      //Increment address */
  /* EEPROM.write(addr, 'C'); */

}

void loop() {}
