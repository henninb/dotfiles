#include <SoftwareSerial.h>
#include "config.h"

/*
neo-6m | esp32-wemos-d1-mini
====================
RX     | TX (pin17)
TX     | RX (pin16)
GND    | GND
VCC    | 5V
*/

#define RXD2 16
#define TXD2 17

/* SoftwareSerial gpsSerial(RXD2, TXD2); */
HardwareSerial gpsSerial(2);

void setup() {
    Serial.begin(9600);
    while (!Serial);

    gpsSerial.begin(9600);
    while(!gpsSerial);

    Serial.println("");
    Serial.println("Remember to to set Both NL & CR in the serial monitor.");
    Serial.println("setup completed...");
}

void loop() {
    if ( gpsSerial.available() )   {  Serial.write( gpsSerial.read() );  }

    if ( Serial.available() )       {  gpsSerial.write( Serial.read() );  }
}
