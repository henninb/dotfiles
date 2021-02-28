void DHT22_Start (void)
{
  Set_Pin_Output(DHT22_PORT, DHT22_PIN); // set the pin as output
  HAL_GPIO_WritePin (DHT22_PORT, DHT22_PIN, 0);   // pull the pin low
  HAL_Delay(1200);   // wait for > 1ms

  HAL_GPIO_WritePin (DHT22_PORT, DHT22_PIN, 1);   // pull the pin high
  delay (20);   // wait for 30us

  Set_Pin_Input(DHT22_PORT, DHT22_PIN);   // set as input
}

void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}
