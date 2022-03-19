#!/bin/sh

cat > driver-nvidia.conf <<EOF
Section "Device"
        Identifier     "NVIDIA Card"
        VendorName     "NVIDIA Corporation"
        BusID          "PCI:1:0:0"
        Driver         "nvidia"
        Option         "AccelMethod" "none"
        Option         "TripleBuffer" "True"
        Option         "MetaModes" "nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
EndSection
EOF

cat > fonts.conf <<EOF
Section "Files"
    FontPath "/usr/local/share/fonts/font-awesome/"
EndSection
EOF

echo "installing packages for a gtx960"
sudo pkg install -y nvidia-driver-460.67
sudo pkg install -y emulators/linux_base-c7
sudo pkg install -y drm-kmod

cat > rc.conf << EOF
linux_enable="YES"
nvidia_enable="YES"
kld_list="linux nvidia nvidia-modeset"
EOF

echo add entries to the rc.conf
cat rc.conf

pciconf -lv | grep -A4 vga

echo "run 'nvidia-settings' to verify the video card settings"
sudo cp -v driver-nvidia.conf /usr/local/etc/X11/xorg.conf.d/

exit 0

gtf 2560 1440 59.95
xrandr --newmode "2560x1440_60.00"  311.83  2560 2744 3024 3488  1440 1441 1444 1490  -HSync +Vsync
xrandr --newmode "2560x1440_59.95"  311.57  2560 2744 3024 3488  1440 1441 1444 1490  -HSync +Vsync
xrandr --addmode default "2560x1440_59.95"
xrandr --output default --mode "2560x1440_59.95"
xrandr --verbose
