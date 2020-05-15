#!/bin/sh

sudo pacman -S vdpauinfo
sudo pacman -S mesa-vdpau
sudo pacman -S libva-utils
sudo pacman -S libva-vdpau-driver libvdpau-va-gl

sudo apt install -y vulkan-utils

echo "i believe this is for AMD graphics cards"
sudo pacman -S vulkan-radeon

echo "session info"
loginctl session-status

vdpauinfo
vainfo

echo Vulkan API
echo mesa-vdpau and also libva-mesa-driver
lspci |grep VGA

echo VDPAU and VAAPI.

exit 0
