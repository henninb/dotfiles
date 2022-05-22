#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  echo eselect kernel list
  echo sudo emerge --update --newuse linux-headers
  echo sudo emerge --update --newuse x11-drivers/nvidia-drivers
  echo sudo emerge --update --newuse media-libs/vulkan-loader
  sudo cp -v nvidia-installer-disable-nouveau.conf /etc/modprobe.d/
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  #sudo pacman -S nvidia lib32-nvidia-utils  --overwrite '*'
  echo
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

if [ ! -f NVIDIA-Linux-x86_64-510.73.05.run ]; then
  # wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/470.94/NVIDIA-Linux-x86_64-470.94.run'
  wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/510.73.05/NVIDIA-Linux-x86_64-510.73.05.run'
fi

echo sudo chvt 3
echo tty with the shortcut - Ctl-Alt-F1-F7
echo sudo sh ./NVIDIA-Linux-x86_64-470.94.run

lsmod | grep nvidia

glxinfo | grep direct

if [ -x "$(command -v nvidia-settings)" ]; then
  nvidia-settings &
fi

exit 0
