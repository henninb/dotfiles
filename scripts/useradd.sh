#!/bin/sh

id -g wheel >/dev/null 2>&1 || sudo groupadd wheel
id -u brian >/dev/null 2>&1 || sudo useradd -m -G wheel -s /bin/bash henninb
id -u flatpak >/dev/null 2>&1 || sudo useradd -M flatpak -s /sbin/nologin
id -u firefox >/dev/null 2>&1 || sudo useradd -M firefox -s /sbin/nologin
id -u arduino >/dev/null 2>&1 || sudo useradd -M arduino -s /sbin/nologin
id -u intellij >/dev/null 2>&1 || sudo useradd -M intellij -s /sbin/nologin
id -u tomcat >/dev/null 2>&1 || sudo useradd -M tomcat -s /sbin/nologin
id -u activemq >/dev/null 2>&1 || sudo useradd -M activemq -s /sbin/nologin
id -u kafka >/dev/null 2>&1 || sudo useradd -M kafka -s /sbin/nologin
id -g dialout >/dev/null 2>&1 ||  sudo groupadd -g 20 dialout

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G wheel "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
  sudo usermod -a -G uucp "$(id -un)"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G wheel "$(id -un)"
  sudo usermod -a -G uucp "$(id -un)"
  sudo usermod -a -G tty "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
  sudo usermod -a -G wireshark "$(id -un)"
  sudo usermod -a -G realtime "$(id -un)" # for jack
elif [ "$OS" = "Void" ]; then
  sudo usermod -a -G libvirt "$(id -un)"
  sudo usermod -a -G audio "$(id -un)"
elif [ "$OS" = "OpenBSD" ]; then
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G wheel "$(id -un)"
elif [ "$OS" = "FreeBSD" ]; then
  sudo pw group add intellij
  sudo pw group add arduino
  sudo pw groupmod dialer -m "$USER"
  sudo pw usermod "$(whoami)" -G intellij
  sudo pw usermod "$(whoami)" -G mpd
  sudo pw usermod "$(whoami)" -G arduino
  sudo pw usermod "$(whoami)" -G operator
  sudo pw adduser intellij -g intellij -d /nonexistent -s /usr/sbin/nologin
  sudo pw adduser arduino -g arduino -d /nonexistent -s /usr/sbin/nologin
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
  sudo usermod -a -G systemd-journal "$(id -un)"
  echo "audio?"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
  echo "audio?"
elif [ "$OS" = "Solus" ]; then
  sudo usermod -a -G wheel "$(id -un)"
  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
elif [ "$OS" = "Gentoo" ]; then
  sudo gpasswd -a $USER pcap
  sudo gpasswd -a $USER audio
  sudo gpasswd -a $USER docker

  sudo usermod -a -G flatpak "$(id -un)"
  sudo usermod -a -G tomcat "$(id -un)"
  sudo usermod -a -G firefox "$(id -un)"
  sudo usermod -a -G intellij "$(id -un)"
  sudo usermod -a -G arduino "$(id -un)"
  sudo usermod -a -G activemq "$(id -un)"
  sudo usermod -a -G kafka "$(id -un)"
  sudo usermod -a -G audio "$(id -un)"
  sudo usermod -a -G docker "$(id -un)"
  sudo usermod -a -G audio "$(id -un)"
elif [ "$OS" = "Darwin" ]; then
  echo "macos"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo "clearlinux"
else
  echo "$OS is not yet implemented."
fi

exit 0

sudo usermod -s /sbin/nologin firefox
sudo usermod -s /sbin/nologin arduino
sudo usermod -s /sbin/nologin intellij
sudo usermod -s /sbin/nologin activemq
sudo usermod -s /sbin/nologin tomcat
sudo usermod -s /sbin/nologin kafka
sudo usermod -s /sbin/nologin oracle

# vim: set ft=sh
