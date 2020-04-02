#!/bin/sh

VER=$(curl -s -f https://www.arduino.cc/en/main/software | grep -o 'arduino-[0-9.]\+[0-9]-windows.exe' | sed 's/arduino-//' | sed 's/-windows.exe//')
echo "$VER"

if [ ! -f "arduino-${VER}-linux64.tar.xz" ]; then
  rm -rf arduino-*-linux64.tar.xz
  curl https://downloads.arduino.cc/arduino-${VER}-linux64.tar.xz --output "arduino-${VER}-linux64.tar.xz"
fi

sudo rm -rf /opt/arduino
sudo rm -rf "/opt/arduino-${VER}"
sudo tar -xJvf "arduino-${VER}-linux64.tar.xz" -C /opt
sudo ln -s "/opt/arduino-${VER}" /opt/arduino

id -u arduino &>/dev/null || sudo useradd arduino -m
sudo chown -R arduino:arduino /opt/arduino/
sudo chown -R arduino:arduino "/opt/arduino-${VER}/"

sudo usermod -a -G arduino "$(whoami)"
# sudo usermod -a -G uucp "$(whoami)"
sudo usermod -a -G tty "$(whoami)"
sudo pacman -S minicom
sudo pacman -S moserial

# cd "$HOME/projects"
# git clone git@github.com:arduino/arduino-cli.git
# cd arduino-cli
# cd "$HOME"
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

exit 0
