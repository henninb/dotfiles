/*
 ESP32 Wemos D1 | FTDI
 VCC            | 3.3v
 GND            | GND
 RX             | TX
 TX             | RX

 GPI0 to GND (on the esp32)
 */

void setup() {
  /* what baud rate should I use */
  Serial.begin(9600);
  while( !Serial);

  pinMode(BUILTIN_LED, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  Serial.println("Hello from ESP32");
  digitalWrite(BUILTIN_LED, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait for a second
  digitalWrite(BUILTIN_LED, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
