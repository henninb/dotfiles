#include <SoftwareSerial.h>
#define RXD2 16
#define TXD2 17

SoftwareSerial ESPserial(RXD2, TXD2); // RX | TX

void setup() {
    Serial.begin(9600);     // communication with the host computer
    //while (!Serial)   { ; }

    // Start the software serial for communication with the ESP8266
    ESPserial.begin(9600);

    Serial.println("");
    Serial.println("Remember to to set Both NL & CR in the serial monitor.");
    Serial.println("Ready");
    Serial.println("");
}

void loop() {
    if ( ESPserial.available() )   {  Serial.write( ESPserial.read() );  }

    if ( Serial.available() )       {  ESPserial.write( Serial.read() );  }
}
