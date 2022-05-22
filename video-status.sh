#!/bin/sh

lspci -k | grep -A 2 -E "(VGA|3D)"

# dead code
if [ 0 -eq 1 ]; then
  sudo emerge --update --newuse x11-misc/vdpauinfo
  sudo emerge --update --newuse hardinfo

  sudo pacman --noconfirm --needed -S vdpauinfo
  sudo pacman --noconfirm --needed -S mesa-vdpau
  sudo pacman --noconfirm --needed -S libva-utils
  sudo pacman --noconfirm --needed -S libva-vdpau-driver libvdpau-va-gl

  sudo xbps-install -y mesa-vdpau
  sudo xbps-install -y mesa-vaapi

  sudo apt install -y vulkan-utils

  echo "i believe this is for AMD graphics cards"
  echo sudo pacman --noconfirm --needed -S vulkan-radeon
  echo sudo xbps-install -y xf86-video-amdgpu
fi

# echo "session info"
# loginctl session-status

if [ -x "$(command -v vdpauinfo)" ]; then
  echo vdpauinfo
  vdpauinfo
fi

if [ -x "$(command -v vainfo)" ]; then
  echo vainfo
  vainfo
fi

# echo Vulkan API
# echo mesa-vdpau and also libva-mesa-driver
lspci | grep VGA

lspci -v | grep VGA
# 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde XT [Radeon HD 7770/8760 / R7 250X] (prog-if 00 [VGA controller])

# echo VDPAU and VAAPI.

exit 0
