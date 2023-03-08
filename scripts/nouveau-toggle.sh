#!/bin/sh

cat > "$HOME/tmp/nvidia-installer-disable-nouveau.conf" <<EOF
blacklist nouveau
options nouveau modeset=0
EOF

sudo cp -v "$HOME/tmp/nvidia-installer-disable-nouveau.conf" /etc/modprobe.d/
sudo /sbin/mkinitrd

exit 0
