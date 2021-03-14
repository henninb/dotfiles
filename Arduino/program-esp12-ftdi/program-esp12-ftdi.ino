/*
  Operational Mode
  ESP12    | FTDI
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  GPIO0    | DTR

  CHPD  - 3.3V
  1000uF capacitor (between VCC and GND), shorter leg GND
  Optional RST - to button for resetting
*/

/*
  Programming Mode
  ESP12    | FTDI
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX
  RST      |RTS
  GPIO0    |DTR

  CHPD  - 3.3V
  1000uF capacitor (between VCC and GND), shorter leg GND
*/

void setup() {
  Serial.begin(9600);
  while (!Serial);
  pinMode(BUILTIN_LED, OUTPUT);
}

void loop() {
  Serial.println("Hello from ESP12");
  digitalWrite(BUILTIN_LED, HIGH);
  delay(1000);
  digitalWrite(BUILTIN_LED, LOW);
  delay(1000);
  Serial.println(millis() / 1000);
}
