#!/bin/sh

cat > "$HOME/tmp/driver-nvidia.conf" <<EOF
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

# cat > "$HOME/tmp/fonts.conf" <<EOF
# Section "Files"
#     FontPath "/usr/local/share/fonts/font-awesome/"
# EndSection
# EOF

doas pkg install -y nvidia-driver-470
sudo pkg install -y emulators/linux_base-c7
doas pkg install -y drm-kmod

doas sysrc nvidia_enable=YES
doas sysrc linux_enable=YES
doas sysrc dbus_enable=YES
doas sysrc hald_enable=YES
doas sysrc kld_list="linux nvidia nvidia-modeset"

pciconf -lv | grep -A4 vga

echo "run 'nvidia-settings' to verify the video card settings"
sudo cp -v "$HOME/tmp/driver-nvidia.conf" /usr/local/etc/X11/xorg.conf.d/

exit 0

# vim: set ft=sh:
