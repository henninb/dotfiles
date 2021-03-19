/*
Connect the Black (Ground) wire to the ground of your chip
Connect the Red (VCC) wire to the power/VCC/5V pin of your chip
Connect the White (DTR) wire to the Reset pin
Connect the Orange (TX) wire to SCK pin (Arduino pin 13)
Connect the Blue (CTS) wire to the MISO pin (Arduino pin 12)
Connect the Green (RTS) wire to MOSI pin (Arduino pin 11)

DTR – Reset the other hardware device
RX – Used to receive the serial data.
TX – Used to transmit the serial data.
VCC – Provides 5V or 3.3V voltage output as per the requirement
CTS – Enable or disable the programming mode of the device
GND – Ground pin

avrdude -c avrisp -p m328p -P com8 -b 19200 -U flash:r:adduinoDownload.hex:i

*/

void setup() {
  Serial.begin(9600);
  while( !Serial);

  pinMode(LED_BUILTIN, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello from Arduino");
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait for a second
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
