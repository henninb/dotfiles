#!/bin/sh

cat > "$HOME/tmp/xorg.conf" <<EOF
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0" 0 0
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
    Option         "Xinerama" "0"
EndSection

Section "Files"
EndSection

Section "InputDevice"

    # generated from data in "/etc/conf.d/gpm"
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol"
    Option         "Device" "/dev/input/mice"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"

    # generated from default
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Monitor"

    # HorizSync source: edid, VertRefresh source: edid
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "DELL P2720D"
    HorizSync       29.0 - 113.0
    VertRefresh     49.0 - 75.0
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "NVIDIA GeForce GTX 1060 6GB"
EndSection

Section "Screen"

# Removed Option "metamodes" "HDMI-0: nvidia-auto-select +0+0, HDMI-1: nvidia-auto-select +3840+0 {rotation=left}"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-1"
    Option         "metamodes" "HDMI-0: nvidia-auto-select +3840+0 {rotation=left}, HDMI-1: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
EOF

cat > "$HOME/tmp/nvidia-installer-disable-nouveau.conf" <<EOF
blacklist nouveau
options nouveau modeset=0
EOF

lspci -k | grep -A 2 -E "(VGA|3D)"
echo 'uninstall'
echo 'sudo sh ./NVIDIA-Linux-x86_64-304.60.run --uninstall'

if command -v pacman; then
  sudo pacman --noconfirm --needed -S linux-headers
  sudo pacman --noconfirm --needed -S glxinfo
fi

if command -v emerge; then
  if ! command -v hardinfo; then
    sudo emerge --update --newuse hardinfo
  fi
  sudo emerge --update --newuse mesa-progs
  sudo emerge --update --newuse linux-headers
fi

# dead code
if [ 0 -eq 1 ]; then
  sudo emerge --update --newuse x11-misc/vdpauinfo

  sudo pacman --noconfirm --needed -S vdpauinfo
  sudo pacman --noconfirm --needed -S mesa-vdpau
  sudo pacman --noconfirm --needed -S libva-utils
  sudo pacman --noconfirm --needed -S libva-vdpau-driver libvdpau-va-gl
  pacman -Qi nvidia
  pacman -Qi nvidia-utils
  pacman -Qi nvidia-libgl

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

if [ -x "$(command -v vulkaninfo)" ]; then
  echo vulkaninfo
  vulkaninfo
fi

# echo Vulkan API
# echo mesa-vdpau and also libva-mesa-driver
lspci | grep VGA

lspci -v | grep VGA
# 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde XT [Radeon HD 7770/8760 / R7 250X] (prog-if 00 [VGA controller])

lsmod | grep -i nvidia

glxinfo | grep direct

echo sudo chvt 3
echo sudo chvt 2
echo "Open tty with the shortcut - Ctl-Alt-(F1-F7)"

if [ -x "$(command -v nvidia-smi)" ]; then
  sudo nvidia-smi
  sudo nvidia-smi -q -d TEMPERATURE
  sudo nvidia-smi --query-gpu=driver_version --format=csv,noheader
  # modinfo "/usr/lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko" | grep ^version
fi

# echo VDPAU and VAAPI.
if [ -x "$(command -v nvidia-settings)" ]; then
  echo nvidia-settings
  nvidia-settings -q NvidiaDriverVersion
else
  echo "nvidia driver is not installed"
fi
 
echo open https://www.nvidia.com/en-us/geforce/drivers/
if [ ! -f "$HOME/tmp/NVIDIA-Linux-x86_64-520.56.06.run" ]; then
  wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/520.56.06/NVIDIA-Linux-x86_64-520.56.06.run' -O "$HOME/tmp/NVIDIA-Linux-x86_64-520.56.06.run"
fi

grep "X Driver" /var/log/Xorg.0.log
lspci -k | grep -A 2 -i "VGA"
modinfo nvidia | grep version


echo "works for the gtx1060 and the gtx960."

exit 0

# vim: set ft=sh
