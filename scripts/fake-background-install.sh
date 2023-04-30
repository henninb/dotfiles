#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S v4l2loopback-dkms
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse media-video/v4l2loopback
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "debian"
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "FreeBSD" ]; then
  echo "freebsd"
elif [ "$OS" = "Solus" ]; then
  echo "solus"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo opensuse
elif [ "$OS" = "Fedora Linux" ]; then
  echo "fedora"
elif [ "$OS" = "Clear Linux OS" ]; then
  echo clearlinux
elif [ "$OS" = "Darwin" ]; then
  echo macos
else
  echo "$OS is not yet implemented."
  exit 1
fi

mkdir -p "$HOME/projects/github.com/fangfufu"
cd "$HOME/projects/github.com/fangfufu" || exit
git clone https://github.com/fangfufu/Linux-Fake-Background-Webcam.git fake-background
cd fake-background
./install.sh
echo install pip3
echo cd "$HOME/projects/github.com/fangfufu/fake-background"
echo ./fake.py --no-foreground --width 640 --height 480 --background-blur 0

exit 0

# vim: set ft=sh:
