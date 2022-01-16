#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  echo sudo emerge --update --newuse x11-drivers/nvidia-drivers
  echo sudo emerge --update --newuse media-libs/vulkan-loader
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman -S nvidia lib32-nvidia-utils
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y xtools
  git clone git@github.com:void-linux/void-packages.git
  cd void-packages || exit
  ./xbps-src binary-bootstrap
  ./xbps-src pkg nvidia-libs-32bit
  ./xbps-src pkg nvidia
  ./xbps-src pkg glibc-32bit
  xi glibc-32bit
  xi nvidia
  xi nvidia-libs-32bit
else
  echo "$OS not configured"
fi

vulkaninfo | less

wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/470.94/NVIDIA-Linux-x86_64-470.94.run'

echo sudo chvt 3
echo tty with the shortcut - Ctl-Alt-F1-F7
sudo sh ./NVIDIA-Linux-x86_64-470.94.run

lsmod | grep nvidia

glxinfo | grep direct

nvidia-settings

exit 0
