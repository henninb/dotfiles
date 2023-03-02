#!/bin/sh

if command -v pacman; then
  sudo pacman --noconfirm --needed -S avr-gcc
  sudo pacman --noconfirm --needed -S avrdude
  sudo pacman --noconfirm --needed -S arduino-cli
fi

if command -v emerge; then
  sudo emerge --update --newuse avrdude
  # sudo emerge --update --newuse avr-gcc
  sudo emerge --update --newuse sys-devel/crossdev
fi

if command -v dnf; then
  sudo dnf install -y avrdude
fi

if command -v xbps-install; then
  sudo xbps-install -y avr-gcc
  sudo xbps-install -y avrdude
  sudo xbps-install -y arduino-cli
fi

if command -v pip; then
  pip install platformio
  pip install esptool
else
  echo pip install is required.
  exit 1
fi

if ! command -v arduino-cli; then
  cd "$HOME/.local"
  curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
fi

arduino-cli core update-index
arduino-cli core install arduino:avr
arduino-cli core install stm32duino:STM32F1
arduino-cli core install esp32:esp32
arduino-cli core install esp8266:esp8266

cat > .gitignore <<EOF
.pio
EOF

log="$HOME/tmp/platformio.$$.log"

projects=$(find . -mindepth 1 -maxdepth 1 -type d | sort | grep -v wifi-repeater-esp32 | grep -v wifi-repeater-esp12 | grep -v micropython-esp32 | grep -v basic-attiny85)

for project in $projects; do
  echo "$project"
  mkdir -p "$project/test"
  touch "$project/test/.save"
  git add -f "$project/test/.save"
  cp .gitignore "$project"
  git add -f "$project/.gitignore"
  touch "$project/readme.md"
  git add -f "$project/readme.md"
  git add -f "$project/src/main.cpp"
  sed -i "s/main.cpp/config.h/g" "$project/Makefile"
  git add -f "$project/Makefile"

  git add -f "$project/platformio.ini"
  if ! grep -q "#define uploadTimestamp" "$project/src/config.h" 2> /dev/null; then
    echo "#define uploadTimestamp \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define ssid" "$project/src/config.h" 2> /dev/null; then
    echo "#define ssid \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define password" "$project/src/config.h" 2> /dev/null; then
    echo "#define password \"\"" >> "$project/src/config.h"
  fi
  if ! grep -q "#define mqttServer" "$project/src/config.h" 2> /dev/null; then
    echo "#define mqttServer \"\"" >> "$project/src/config.h"
  fi
  # echo "date=\$(shell date '+%Y-%m-%d %H:%M:%S')" |cat - "$project/Makefile" > /tmp/out && mv /tmp/out "$project/Makefile"
  cd "$project" || exit
  if make > /dev/null 2>&1; then
    echo "$project - compile success" | tee -a "${log}"
  else
    echo "$project - compile failed" | tee -a "${log}"
  fi
  cd ..
done

exit 0
