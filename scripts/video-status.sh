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
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/input/mice"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "LG Electronics LG HDR 4K"
    HorizSync       30.0 - 135.0
    VertRefresh     56.0 - 61.0
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "NVIDIA GeForce GTX 1060 6GB"
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-1"
    Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0, HDMI-1: nvidia-auto-select +3840+0 {rotation=left}"
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

ver=570.86.16

lspci -k | grep -A 2 -E "(VGA|3D)"
echo 'uninstall'
echo "sudo sh ./NVIDIA-Linux-x86_64-${ver}.run --uninstall"

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S linux-headers
  doas pacman --noconfirm --needed -S glxinfo
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v hardinfo; then
    doas emerge --update --newuse hardinfo
  fi
  doas emerge --update --newuse mesa-progs
  doas emerge --update --newuse linux-headers
  sudo emerge --update --newuse media-libs/vulkan-loader
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo debian
elif [ "$OS" = "Void" ]; then
  echo "void"
elif [ "$OS" = "OpenBSD" ]; then
  echo "openbsd"
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

# dead code
if [ 0 -eq 1 ]; then
  sudo emerge --update --newuse x11-misc/vdpauinfo

  doas pacman --noconfirm --needed -S vdpauinfo
  doas pacman --noconfirm --needed -S mesa-vdpau
  doas pacman --noconfirm --needed -S libva-utils
  doas pacman --noconfirm --needed -S libva-vdpau-driver libvdpau-va-gl
  pacman -Qi nvidia
  pacman -Qi nvidia-utils
  pacman -Qi nvidia-libgl

  doas xbps-install -y mesa-vdpau
  doas xbps-install -y mesa-vaapi

  doas apt install -y vulkan-utils

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
  doas nvidia-smi
  doas nvidia-smi -q -d TEMPERATURE
  doas nvidia-smi --query-gpu=driver_version --format=csv,noheader
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
# if [ ! -f "$HOME/tmp/NVIDIA-Linux-x86_64-525.89.02.run" ]; then
#   wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/525.89.02/NVIDIA-Linux-x86_64-525.89.02.run' -O "$HOME/tmp/NVIDIA-Linux-x86_64-525.89.02.run"
# fi

if [ ! -f "$HOME/tmp/NVIDIA-Linux-x86_64-${ver}.run" ]; then
  wget "https://us.download.nvidia.com/XFree86/Linux-x86_64/${ver}/NVIDIA-Linux-x86_64-${ver}.run" -O "$HOME/tmp/NVIDIA-Linux-x86_64-${ver}.run"
fi

grep "X Driver" /var/log/Xorg.0.log
lspci -k | grep -A 2 -i "VGA"
modinfo nvidia | grep version


echo "works for the gtx1060 and the gtx960."

exit 0

# vim: set ft=sh:
