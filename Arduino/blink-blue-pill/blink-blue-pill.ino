void setup() {
  Serial.begin(115200);
  while (!Serial);
  pinMode(PC13, OUTPUT);
  Serial.println("STM32 blink test");
}

void loop() {
  digitalWrite(PC13, HIGH);
  delay(1000);
  digitalWrite(PC13, LOW);
  delay(1000);
  Serial.print("Hello from STM32! ");
  Serial.println(millis() / 1000);
}
