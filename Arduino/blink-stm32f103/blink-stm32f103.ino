/*
Via FTDI converter
Move boot0 into the 1 position

FTDI | stm32f103
RX   | PC9
TX   | PC10
GND  | GND
3.3V | 3.3V

*/

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
  delay(1000);
  Serial.println(millis() / 1000);
}
