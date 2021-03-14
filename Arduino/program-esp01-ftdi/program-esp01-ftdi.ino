/*
  Operational Mode
  ESP01    | FTDI
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX

  CHPD  - 3.3V
  GPIO0  - DTR
  1000uF capacitor (between VCC and GND), shorter leg GND

  Optional RST - to button for resetting the program or to RTS on the FTDI

  Programming Mode
*/

void setup() {
  Serial.begin(9600);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);
}

void loop() {
  Serial.println("Hello from ESP01");
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
  Serial.println(millis() / 1000);
}
