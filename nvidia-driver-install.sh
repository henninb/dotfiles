#!/bin/sh

echo sudo emerge --update --newuse x11-drivers/nvidia-drivers

sudo pacman -S nvidia lib32-nvidia-utils
sudo emerge --update --newuse media-libs/vulkan-loader

vulkaninfo | less

wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/470.94/NVIDIA-Linux-x86_64-470.94.run'

echo sudo chvt 3
echo tty with the shortcut - Ctl-Alt-F1-F7
sudo sh ./NVIDIA-Linux-x86_64-470.94.run

lsmod | grep nvidia

glxinfo | grep direct

nvidia-settings

exit 0
