/*
  ESP12    |  FTDI
  VCC      | 3.3V
  GND      | GND
  TX       | RX
  RX       | TX

  CHPD  - 3.3V
  GPIO15 - GND
  GPIO0  - GND
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
