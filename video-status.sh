#!/bin/sh

lspci -k | grep -A 2 -E "(VGA|3D)"

sudo pacman --noconfirm --needed -S vdpauinfo
sudo pacman --noconfirm --needed -S mesa-vdpau
sudo pacman --noconfirm --needed -S libva-utils
sudo pacman --noconfirm --needed -S libva-vdpau-driver libvdpau-va-gl

sudo apt install -y vulkan-utils

echo "i believe this is for AMD graphics cards"
echo sudo pacman --noconfirm --needed -S vulkan-radeon

echo "session info"
loginctl session-status

vdpauinfo
vainfo

echo Vulkan API
echo mesa-vdpau and also libva-mesa-driver
lspci | grep VGA

echo VDPAU and VAAPI.

exit 0
