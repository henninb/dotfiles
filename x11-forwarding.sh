#!/bin/sh

#xrandr -q

if [ "${OS}" = "FreeBSD" ]; then
  echo install these packages on the guest
  echo
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo install these packages on the guest
  sudo apt install x11-server
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo install these packages on the guest
  sudo pacman --noconfirm --needed -S xorg-server
  sudo pacman --noconfirm --needed -S xorg-xauth
  # sudo pacman -S xorg openbox
fi


sudo touch /etc/ssh/sshd_config
ssh -X henninb@168.62.111.163 env

echo /etc/ssh/sshd_config
echo X11Forwarding yes
echo X11DisplayOffset 10

echo DISPLAY=host:display:screen


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
