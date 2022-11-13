#!/bin/sh

cat > "$HOME/tmp/nvidia.hook" <<EOF
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
  sudo cp -v nvidia-installer-disable-nouveau.conf /etc/modprobe.d/
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo mkdir -p /etc/pacman.d/hooks
  sudo mv -v "$HOME/tmp/nvidia.hook" /etc/pacman.d/hooks/nvidia.hook
  #sudo pacman -S nvidia lib32-nvidia-utils  --overwrite '*'
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

if [ -x "$(command -v nvidia-settings)" ]; then
  nvidia-settings &
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exit 0

# vim: set ft=sh
