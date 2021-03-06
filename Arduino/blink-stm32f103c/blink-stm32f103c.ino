void setup() {
  Serial.begin(9600);
  while (!Serial);
  pinMode(PC13, OUTPUT);
}

void loop() {
  Serial.println("Hello from STM32");
  digitalWrite(PC13, HIGH);
  delay(1000);
  digitalWrite(PC13, LOW);
  delay(3000);
  Serial.println(millis() / 1000);
}
