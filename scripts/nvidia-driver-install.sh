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

sudo mkdir -p /etc/modprobe.d/

if [ "$OS" = "Gentoo" ]; then
  echo eselect kernel list
  echo sudo emerge --update --newuse linux-headers
  echo sudo emerge --update --newuse x11-drivers/nvidia-drivers
  echo sudo emerge --update --newuse media-libs/vulkan-loader
  sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modprobe.d/
  sudo cp -v "$HOME/tmp/xorg.conf" /etc/X11/xorg.conf
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo mkdir -p /etc/pacman.d/hooks
  sudo mv -v "$HOME/tmp/nvidia.hook" /etc/pacman.d/hooks/nvidia.hook
  doas pacman --noconfirm --needed -S nvidia
  doas pacman --noconfirm --needed -S nvidia-utils
  doas pacman --noconfirm --needed -S nvidia-settings
  doas pacman --noconfirm --needed -S opencl-nvidia
  doas pacman --noconfirm --needed -S nvidia lib32-nvidia-utils
  doas pacman --noconfirm --needed -S nvidia lib32-nvidia-libgl
  doas pacman --noconfirm --needed -S vulkan-tools
  doas pacman --noconfirm --needed -S ttf-liberation
  doas pacman --noconfirm --needed -S vulkan-headers
  doas pacman -R amdvlk
  sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modprobe.d/
  sudo cp -v "$HOME/tmp/xorg.conf" /etc/X11/xorg.conf
  #sudo pacman -S nvidia lib32-nvidia-utils  --overwrite '*'
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  doas zypper install -y kernel-source
  doas zypper install -y libva-utils
  doas zypper install -y kernel-devel kernel-source gcc make dkms acpid libglvnd libglvnd-devel
  doas zypper install -y libvdpau1 libva-vdpau-driver libva-utils
  echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/blacklist.conf
  # zypper se x11-video-nvidiaG0* nvidia-video-G03*
  echo sudo systemctl set-default graphical.target
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/blacklist.conf
  doas dnf remove akmod-nvidia
  # sudo dnf install -y akmod-nvidia "kernel-devel-uname-r == $(uname -r)"
  doas dnf install -y akmod-nvidia
  # sudo dnf install -y akmod-nvidia "kernel-devel-uname-r=$(uname -r)"
  # echo 'https://phoenixnap.com/kb/fedora-nvidia-drivers'
  # sudo dnf remove xorg-x11-drv-nouveau
  # echo /etc/default/grub
  # echo GRUB_CMDLINE_LINUX="text rd.driver.blacklist=nouveau"
  # echo sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modprobe.d/blacklist.conf
  # echo sudo systemctl set-default multi-user.target
  # echo sudo systemctl set-default graphical.target
  # sudo dnf install -y akmod-nvidia
  doas dnf install -y xorg-x11-drv-nvidia-cuda
  doas dnf install -y kernel-headers
  doas dnf install -y kernel-devel
  # rpm -qa | grep -E "kernel-devel|kernel-headers"
  # sudo dnf install "kernel-devel-uname-r == $(uname -r)"
  doas akmods --force
  sudo dracut --force /boot/initramfs-$(uname -r).img $(uname -r)
elif [ "$OS" = "Ubuntu" ]; then
  sudo add-apt-repository ppa:graphics-drivers/ppa
  doas apt install -y libvulkan-dev
  doas apt install -y libvulkan1
  doas apt install -y mesa-vulkan-drivers
  doas apt install -y vulkan-utils
  # sudo apt install nvidia-graphics-drivers-396 nvidia-settings vulkan vulkan-utils
elif [ "$OS" = "Void" ]; then
  doas xbps-install -y xtools
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

ver=535.54.03
if [ ! -f "$HOME/tmp/NVIDIA-Linux-x86_64-${ver}.run" ]; then
  wget "https://us.download.nvidia.com/XFree86/Linux-x86_64/${ver}/NVIDIA-Linux-x86_64-${ver}.run" -O "$HOME/tmp/NVIDIA-Linux-x86_64-${ver}.run"
fi

echo sudo chvt 3
echo tty with the shortcut - Ctl-Alt-F1-F7
echo sudo sh "./NVIDIA-Linux-x86_64-${ver}.run"

lsmod | grep nvidia

glxinfo | grep direct

if command -v nvidia-settings; then
  nvidia-settings &
fi

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

exit 0

# vim: set ft=sh:
