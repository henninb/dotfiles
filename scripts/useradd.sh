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
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G wheel "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
  doas usermod -a -G uucp "$(id -un)"
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G wheel "$(id -un)"
  doas usermod -a -G uucp "$(id -un)"
  doas usermod -a -G tty "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
  doas usermod -a -G wireshark "$(id -un)"
  doas usermod -a -G realtime "$(id -un)" # for jack
elif [ "$OS" = "Void" ]; then
  doas usermod -a -G libvirt "$(id -un)"
  doas usermod -a -G audio "$(id -un)"
elif [ "$OS" = "OpenBSD" ]; then
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G wheel "$(id -un)"
elif [ "$OS" = "FreeBSD" ]; then
  doas pw group add intellij
  doas pw group add arduino
  doas pw groupmod dialer -m "$USER"
  doas pw usermod "$(whoami)" -G intellij
  doas pw usermod "$(whoami)" -G mpd
  doas pw usermod "$(whoami)" -G arduino
  doas pw usermod "$(whoami)" -G operator
  sudo pw adduser intellij -g intellij -d /nonexistent -s /usr/sbin/nologin
  sudo pw adduser arduino -g arduino -d /nonexistent -s /usr/sbin/nologin
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
  doas usermod -a -G systemd-journal "$(id -un)"
  echo "audio?"
elif [ "$OS" = "Fedora Linux" ]; then
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
  echo "audio?"
elif [ "$OS" = "Solus" ]; then
  doas usermod -a -G wheel "$(id -un)"
  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
elif [ "$OS" = "Gentoo" ]; then
  doas gpasswd -a $USER pcap
  doas gpasswd -a $USER audio
  doas gpasswd -a $USER docker

  doas usermod -aG lp $USER

  doas usermod -a -G flatpak "$(id -un)"
  doas usermod -a -G tomcat "$(id -un)"
  doas usermod -a -G firefox "$(id -un)"
  doas usermod -a -G intellij "$(id -un)"
  doas usermod -a -G arduino "$(id -un)"
  doas usermod -a -G activemq "$(id -un)"
  doas usermod -a -G kafka "$(id -un)"
  doas usermod -a -G audio "$(id -un)"
  doas usermod -a -G docker "$(id -un)"
  doas usermod -a -G audio "$(id -un)"
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

# vim: set ft=sh:
