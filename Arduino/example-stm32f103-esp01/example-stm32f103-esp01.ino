//Interfacing ESP8266 Wi-Fi with STM32F103C8
//NOTE: Serial2 (TX2, RX2)is connected with ESP8266(RX,TX)respectively with baud rate (9600)

int incomingByte = 0;

void setup()
{
   Serial.begin(9600);     //begins serial monitor with baud rate 9600
   while (!Serial);
   Serial2.begin(9600);   //begins serial communication with esp8266 with baud rate 9600 (Change according to your esp8266 module)
   while (!Serial2);
   Serial.println("System Ready..");
}

void loop() {
   while(Serial2.available()) {
     // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();

    // say what you got:
    Serial.print("I received: ");
    Serial.println(incomingByte, DEC);
  }
  delay(100);
 }
}
