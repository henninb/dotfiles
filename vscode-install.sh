#!/bin/sh

RASPI_IP=$(nmap -sP 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')

echo $OSTYPE

if [ "$OS" = "Darwin" ]; then
  echo $(code --version)
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.zip
  wget https://go.microsoft.com/fwlink/?LinkID=620882 -O code-stable-latest.zip
  unzip -o code-stable-latest.zip
  sudo mv -v Visual\ Studio\ Code.app /Applications
  #id -g vscode &>/dev/null || sudo groupadd vscode
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  echo $(code --version)
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.tar.gz
  wget https://go.microsoft.com/fwlink/?LinkID=620884 -O code-stable-latest.tar.gz
  scp pi@${RASPI_IP}:/home/pi/downloads/code-stable-latest.tar.gz .
  sudo tar -xvf code-stable-latest.tar.gz -C /opt
  sudo mv /opt/VSCode-linux-x64 /opt/vscode
  sudo chmod -R 775 /opt/vscode
  id -g vscode &>/dev/null || sudo groupadd vscode
elif [ "$OS" = "Arch Linux" ]; then
  echo arch
  echo $(code --version)
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.tar.gz
  wget https://go.microsoft.com/fwlink/?LinkID=620884 -O code-stable-latest.tar.gz
  sudo tar -xvf code-stable-latest.tar.gz -C /opt
  sudo mv /opt/VSCode-linux-x64 /opt/vscode
  sudo chmod -R 775 /opt/vscode
  id -g vscode &>/dev/null || sudo groupadd vscode
else
  echo $OS is not yet implemented.
  exit 1
fi

git clone https://github.com/dracula/visual-studio-code.git ~/.vscode/extensions/theme-dracula
cd ~/.vscode/extensions/theme-dracula
npm install
npm run build

exit 0
