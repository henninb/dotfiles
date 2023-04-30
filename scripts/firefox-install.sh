#!/usr/bin/env sh

FOX_VER=$(curl -sfI 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' | grep -o 'firefox-[0-9.]\+[0-9]' | sed 's/firefox-//')

echo "ver=$FOX_VER"
echo "act=$ACTUAL_VER"

if [ -f "/opt/firefox/firefox" ]; then
  ACTUAL_VER=$(/opt/firefox/firefox --version | grep -o '[0-9.]\+[0-9]')

  if [ "$ACTUAL_VER" = "$FOX_VER" ]; then
    echo "already at the latest version $FOX_VER."
  fi
fi

doas groupadd firefox
sudo useradd -s /sbin/nologin -g firefox firefox
echo "Press enter to continue"
read -r x
echo "$x" > /dev/null

if [ ! -f "firefox-${FOX_VER}.tar.bz2" ]; then
  rm -rf firefox-*.tar.bz2
  if ! scp "pi@${RASPI_IP}:/home/pi/downloads/firefox-${FOX_VER}.tar.bz2" . ; then
    if ! wget "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FOX_VER}/linux-x86_64/en-US/firefox-${FOX_VER}.tar.bz2" ; then
      scp "firefox-${FOX_VER}.tar.bz2" "pi@${RASPI_IP}:/home/pi/downloads/"
    fi
  fi
fi

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S net-tools psmisc wget curl gtk3 dbus-glib libxt dbus-glib
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -f libcairo2
  doas zypper install -y dbus-1-glib
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y wget
  doas xbps-install -y gtk+3-devel
  doas xbps-install -y dbus-glib
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Solus" ]; then
  sudo mkdir -p /opt
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "openSUSE Leap" ]; then
  doas zypper install curl wget
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Fedora Linux" ]; then
  doas dnf install -y curl
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "FreeBSD" ]; then
  rm -rf tomcat.service
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse dbus-glib
  doas emerge --update --newuse libXt
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  doas apt install -y net-tools psmisc wget curl
  doas apt install -y libgtk-3-dev
  sudo rm -rf /opt/firefox
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
elif [ "$OS" = "CentOS Linux" ]; then
  sudo rm -rf /opt/firefox
  doas yum install -y net-tools wget curl
  sudo tar -xjvf "firefox-${FOX_VER}.tar.bz2" -C /opt
  sudo chown -R firefox:firefox /opt/firefox
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo "Installed version: $(/opt/firefox/firefox --version)"

exit 0

# vim: set ft=sh:
