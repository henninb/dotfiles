#!/bin/sh

cat > devfs.rules <<EOF
 [localrules=10]
        add path 'ugen*' mode 0660 group operator
        add path 'usb/*'  mode 0660 group operator
        add path 'usb' mode 0770 group operator
EOF

VER=$(curl -s -f https://www.arduino.cc/en/main/software | grep -o 'arduino-[0-9.]\+[0-9]-windows.exe' | sed 's/arduino-//' | sed 's/-windows.exe//')
echo "VER=$VER"

VER=1.8.13

if [ ! -f "arduino-${VER}-linux64.tar.xz" ]; then
  rm -rf arduino-*-linux64.tar.xz
  curl "https://downloads.arduino.cc/arduino-${VER}-linux64.tar.xz" --output "arduino-${VER}-linux64.tar.xz"
fi

echo "https://downloads.arduino.cc/arduino-${VER}-linux64.tar.xz"

sudo mkdir -p /opt/
sudo rm -rf /opt/arduino
sudo rm -rf "/opt/arduino-${VER}"
sudo tar -xJvf "arduino-${VER}-linux64.tar.xz" -C /opt
sudo ln -sfn "/opt/arduino-${VER}" /opt/arduino


if [ "${OS}" = "FreeBSD" ]; then
  doas pw groupmod operator -m "$(whoami)"
  echo rc.conf
  echo devfs_system_ruleset="localrules"
  sudo mv devfs.rules /etc/devfs.rules
  doas service devfs restart
fi

id -u arduino >/dev/null 2>&1 || sudo useradd -s /sbin/nologin arduino -m
sudo chown -R arduino:arduino /opt/arduino/
sudo chown -R arduino:arduino "/opt/arduino-${VER}/"

doas usermod -a -G arduino "$(whoami)"
# sudo usermod -a -G uucp "$(whoami)"
doas usermod -a -G tty "$(whoami)"
doas usermod -a -G dialout "$(whoami)"
doas pacman --noconfirm --needed -S minicom
doas pacman --noconfirm --needed -S moserial
echo stty -F /dev/ttyUSB0 hupcl
echo stty -F /dev/ttyUSB0 -hupcl
echo stty -a -F /dev/ttyUSB0

echo "go get -u github.com/arduino/arduino-cli"
export GO111MODULE=on
go get -u github.com/arduino/arduino-cli

pip install esptool --user
pip install platformio --user

# arduino-cli core search arduino
# arduino-cli core search leonardo
# arduino-cli core search uno
# arduino-cli core search samd

# Arduino board support like Leonardo/Uno
arduino-cli core update-index
arduino-cli core install arduino:avr
# Or if you need SAMD21/SAMD51 support:
# arduino-cli core install arduino:samd
arduino-cli core install esp8266:esp8266
arduino-cli core install esp32:esp32
arduino-cli core install stm32duino:STM32F1
arduino-cli core install STM32:stm32

arduino-cli board listall

# arduino-cli core search stm32 --additional-urls 'http://dan.drown.org/stm32duino/package_STM32duino_index.json'

pip install pyserial --user

echo arduino-cli sketch new example-arduino
arduino-cli compile --fqbn arduino:avr:uno example-arduino
arduino-cli compile --fqbn esp8266:esp8266:d1_mini example-arduino
arduino-cli compile --fqbn esp32:esp32:d1_mini32 example-arduino

arduino-cli compile --fqbn STM32:stm32:GenF3 ~/Arduino/blink-blue-pill
arduino-cli compile --fqbn stm32duino:STM32F1:genericSTM32F103C6 ~/Arduino/blink-blue-pill
arduino-cli upload --port /dev/ttyUSB0 --fqbn stm32duino:STM32F1:genericSTM32F103C6:upload_method=serialMethod ~/Arduino/blink-blue-pill

arduino-cli compile --fqbn esp32:esp32:d1_mini32 ~/Arduino/esp32-ntp-print
arduino-cli upload --port /dev/ttyUSB1 --fqbn esp32:esp32:d1_mini32 ~/Arduino/esp32-ntp-print

arduino-cli board list

"$HOME/.arduino15/packages/esp8266/hardware/esp8266/2.6.3/tools/esptool/esptool.py" erase_flash

"$HOME/.arduino15/packages/esp32/hardware/esp32/1.0.4/tools/esptool.py" erase_flash

"$HOME/.arduino15/packages/esp32/hardware/esp32/1.0.4/tools/esptool.py" read_mac

exit 0

# vim: set ft=sh:
