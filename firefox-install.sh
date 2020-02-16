#!/usr/bin/env sh

RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')
FOX_VER=$(curl -sfI 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' | grep -o 'firefox-[0-9.]\+[0-9]' | sed 's/firefox-//')

echo "$FOX_VER"
echo "$ACTUAL_VER"

ACTUAL_VER=$(/opt/firefox/firefox --version | grep -o '[0-9.]\+[0-9]')

if [ "$ACTUAL_VER" = "$FOX_VER" ]; then
  echo "already at the latest version $FOX_VER."
  exit 0
fi

sudo groupadd firefox
sudo useradd -g firefox firefox
read -p "Press enter to continue"

if [ ! -f "firefox-${FOX_VER}.tar.bz2" ]; then
  rm -rf firefox-*.tar.bz2
  scp "pi@${RASPI_IP}:/home/pi/downloads/firefox-${FOX_VER}.tar.bz2" .
  if ! wget "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FOX_VER}/linux-x86_64/en-US/firefox-${FOX_VER}.tar.bz2" ; then
    scp "firefox-${FOX_VER}.tar.bz2" "pi@${RASPI_IP}:/home/pi/downloads/"
  fi
fi

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S net-tools psmisc wget curl gtk3 dbus-glib libxt dbus-glib
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y wget
  sudo xbps-install -y wget
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo zypper install curl wget
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y curl
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "FreeBSD" ]; then
  rm -rf tomcat.service
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse dbus-glib
  sudo emerge --update --newuse libXt
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y net-tools psmisc wget curl
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "CentOS Linux" ]; then
  sudo rm -rf /opt/firefox
  sudo yum install -y net-tools wget curl java-1.8.0-openjdk
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo "Installed version: $(/opt/firefox/firefox --version)"

exit 0
