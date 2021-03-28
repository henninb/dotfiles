#!/bin/sh

cat > .gitignore <<EOF
.pio
EOF

# ls -1
projects="blink-arduino-pro-mini blink-arduino-uno blink-esp01-1m blink-esp12 blink-esp32-wemos-d1-mini blink-stm32f103 blink-wemos-d1-mini bme280-arduino-uno bme280-stm32f103 bme280-weather-wemos-d1-mini dht22-arduino-pro-mini dht22-arduino-uno dht22-esp01-1m dht22-stm32f103 dht22-wemos-d1-mini hc-sr04-distance-arduino-uno hc-sr04-distance-wemos-d1-mini http-post-weather-over-serial-esp01 http-post-weather-over-serial-stm32f013 http-server-wemos-d1-mini i2c-scanner-arduino-uno i2c-scanner-esp01-1m i2c-scanner-stm32f103 i2c-scanner-wemos-d1-mini lq1602-pcf8574-i2c-display-arduino-uno lq1602-pcf8574-i2c-display-esp01-1m lq1602-pcf8574-i2c-display-stm32f103 lq1602-pcf8574-i2c-display-wemos-d1-mini lq1602-pcf8574-i2c-primes-stm32f103 lq1602-pcf8574-i2c-primes-wemos-d1-mini neo-6m-gps-arduino-uno neo-6m-gps-serial-arduino-uno neo-6m-gps-stm32f103 neo-6m-gps-with-sdcard-stm32f103 nrf24l01-radio-receiver-arduino-uno nrf24l01-radio-receiver-stm32f103c nrf24l01-radio-transmitter-arduino-uno nrf24l01-radio-transmitter-stm32f103c ntp-esp32-wemos-d1-mini rfm95-sx1276-lora-receiver-arduino-pro-mini-8mHz rfm95-sx1276-lora-receiver-stm32f103 rfm95-sx1276-lora-transmitter-arduino-pro-mini-8mHz rfm95-sx1276-lora-transmitter-stm32f103 rfm95-sx1276-radio-receiver-arduino-pro-mini-8mHz rfm95-sx1276-radio-receiver-stm32f103 rfm95-sx1276-radio-transmitter-arduino-pro-mini-8mHz rfm95-sx1276-radio-transmitter-stm32f103 sdcard-stm32f103 wifi-network-scanner-esp01-1m ws2812b-neopixel-arduino-uno ws2812b-neopixel-stm32f103c"

for project in $projects; do
  echo "$project"
  mkdir -p "$project/test"
  touch "$project/test/.save"
  git add -f "$project/test/.save"
  cp .gitignore "$project"
  git add -f "$project/.gitignore"
done

exit 0
