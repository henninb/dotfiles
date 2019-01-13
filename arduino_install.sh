#!/bin/sh

RASPI_IP=$(nmap -sP 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')
VER=$(curl -f https://www.arduino.cc/en/main/software | grep -o 'arduino-[0-9.]\+[0-9]-windows.exe' | sed 's/arduino-//' | sed 's/-windows.exe//')
echo $VER

if [ ! -f "arduino-${VER}-linux64.tar.xz" ]; then
  rm -rf arduino-*-linux64.tar.xz
  curl https://downloads.arduino.cc/arduino-${VER}-linux64.tar.xz --output arduino-${VER}-linux64.tar.xz
fi

sudo rm -rf /opt/arduino
sudo rm -rf /opt/arduino-${VER}
sudo tar -xJvf arduino-${VER}-linux64.tar.xz -C /opt
sudo ln -s /opt/arduino-${VER} /opt/arduino

id -u arduino &>/dev/null || sudo useradd arduino -m
sudo chown -R arduino:arduino /opt/arduino/
sudo chown -R arduino:arduino /opt/arduino-${VER}/

exit 0
