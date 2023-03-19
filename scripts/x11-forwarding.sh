#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo install these packages on the guest
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S xorg-xauth
elif [ "$OS" = "Gentoo" ]; then
  echo "sudo emerge --update --newuse"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo install these packages on the guest
  sudo apt install x11-server
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo touch /etc/ssh/sshd_config
ssh -X henninb@168.62.111.163 env

echo /etc/ssh/sshd_config
echo X11Forwarding yes
echo X11DisplayOffset 10

echo DISPLAY=host:display:screen


#xrandr -q
# cat /var/run/sshd.pid | sudo xargs kill -1
sudo kill -1 "$(cat /var/run/sshd.pid)"
xauth list
echo xhost + # insecure
netstat -an | grep 'tcp.*6000.*LISTEN'

echo Xephyr
echo on the linux server set the display to localhost:10.0
echo export DISPLAY=localhost:10.0

echo on the mac set the display to :0.0
echo export DISPLAY=:0.0
echo I know 6000 is default for X11, but I thought the app would come to the Windows system on port 22 since its using SSH.

exit 0

# vim: set ft=sh
