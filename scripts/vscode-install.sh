#!/bin/sh

if [ "$OS" = "Darwin" ]; then
  code --version
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.zip
  wget 'https://go.microsoft.com/fwlink/?LinkID=620882' -O code-stable-latest.zip
  unzip -o code-stable-latest.zip
  sudo mv -v Visual\ Studio\ Code.app /Applications
  #id -g vscode &>/dev/null || sudo groupadd vscode
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y nss
  code --version
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.tar.gz
  wget 'https://go.microsoft.com/fwlink/?LinkID=620884' -O code-stable-latest.tar.gz
  sudo tar -xvf code-stable-latest.tar.gz -C /opt
  sudo mv /opt/VSCode-linux-x64 /opt/vscode
  sudo chmod -R 775 /opt/vscode
  id -g vscode >/dev/null || sudo groupadd vscode
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse nss
  code --version
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.tar.gz
  wget 'https://go.microsoft.com/fwlink/?LinkID=620884' -O code-stable-latest.tar.gz
  sudo tar -xvf code-stable-latest.tar.gz -C /opt
  sudo mv /opt/VSCode-linux-x64 /opt/vscode
  sudo chmod -R 775 /opt/vscode
  id -g vscode >/dev/null || sudo groupadd vscode
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  doas apt install -y nss
  code --version
  sudo rm -rf /opt/vscode
  rm -rf code-stable-latest.tar.gz
  wget 'https://go.microsoft.com/fwlink/?LinkID=620884' -O code-stable-latest.tar.gz
  scp "pi:/home/pi/downloads/code-stable-latest.tar.gz" .
  sudo tar -xvf code-stable-latest.tar.gz -C /opt
  sudo mv /opt/VSCode-linux-x64 /opt/vscode
  sudo chmod -R 775 /opt/vscode
  id -g vscode >/dev/null || sudo groupadd vscode
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  yay --noconfirm --needed -S visual-studio-code-bin
  # sudo rm -rf /opt/vscode
  # rm -rf code-stable-latest.tar.gz
  # wget https://go.microsoft.com/fwlink/?LinkID=620884 -O code-stable-latest.tar.gz
  # sudo tar -xvf code-stable-latest.tar.gz -C /opt
  # sudo mv /opt/VSCode-linux-x64 /opt/vscode
  # sudo chmod -R 775 /opt/vscode
  # id -g vscode > /dev/null || sudo groupadd vscode
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "clearlinux"
else
  echo "$OS is not yet implemented."
  exit 1
fi

git clone https://github.com/dracula/visual-studio-code.git ~/.vscode/extensions/theme-dracula
cd ~/.vscode/extensions/theme-dracula || exit
npm install
npm run build

exit 0

# vim: set ft=sh:
