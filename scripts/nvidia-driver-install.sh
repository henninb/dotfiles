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
    # generated from default
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
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

cat > "$HOME/tmp/nvidia.hook" <<'EOF'
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF

if [ "$OS" = "Gentoo" ]; then
  echo eselect kernel list
  echo sudo emerge --update --newuse linux-headers
  echo sudo emerge --update --newuse x11-drivers/nvidia-drivers
  echo sudo emerge --update --newuse media-libs/vulkan-loader
  sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modeprobe.d/
  sudo cp -v "$HOME/tmp/xorg.conf" /etc/X11/xorg.conf
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo mkdir -p /etc/pacman.d/hooks
  sudo mv -v "$HOME/tmp/nvidia.hook" /etc/pacman.d/hooks/nvidia.hook
  sudo pacman --noconfirm --needed -S nvidia
  sudo pacman --noconfirm --needed -S nvidia-utils
  sudo pacman --noconfirm --needed -S nvidia-settings
  sudo pacman --noconfirm --needed -S opencl-nvidia
  sudo pacman --noconfirm --needed -S nvidia lib32-nvidia-utils
  sudo pacman --noconfirm --needed -S nvidia lib32-nvidia-libgl
  sudo pacman --noconfirm --needed -S vulkan-tools
  sudo pacman --noconfirm --needed -S ttf-liberation
  sudo pacman --noconfirm --needed -S vulkan-headers
  sudo pacman -R amdvlk
  sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modeprobe.d/
  sudo cp -v "$HOME/tmp/xorg.conf" /etc/X11/xorg.conf
  #sudo pacman -S nvidia lib32-nvidia-utils  --overwrite '*'
elif [ "$OS" = "Fedora Linux" ]; then
  echo 'https://phoenixnap.com/kb/fedora-nvidia-drivers'
  sudo dnf remove xorg-x11-drv-nouveau
  echo /etc/default/grub
  echo GRUB_CMDLINE_LINUX="text rd.driver.blacklist=nouveau"
  echosudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modeprobe.d/blacklist.conf
  echo sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  echo sudo dracut --force /boot/initramfs-$(uname -r).img $(uname -r)
  echo sudo systemctl set-default multi-user.target
  echo sudo systemctl set-default graphical.target
  sudo dnf install akmod-nvidia
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

if [ ! -f "$HOME/tmp/NVIDIA-Linux-x86_64-515.76.run" ]; then
  wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/515.76/NVIDIA-Linux-x86_64-515.76.run' -O "$HOME/tmp/NVIDIA-Linux-x86_64-515.76.run"
fi

echo sudo chvt 3
echo tty with the shortcut - Ctl-Alt-F1-F7
echo sudo sh ./NVIDIA-Linux-x86_64-470.94.run

lsmod | grep nvidia

glxinfo | grep direct

if command -v nvidia-settings; then
  nvidia-settings &
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exit 0

# vim: set ft=sh
