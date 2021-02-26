#!/bin/sh

cat > sddm-theme.conf <<EOF
[Theme]
#Current=maldives
Current=elarun
EOF

sudo pacman -S sddm
sudo systemctl enable sddm.service -f
sudo systemctl disable lightdm

sudo mkdir -p /etc/sddm.conf.d/
sudo mv -v sddm-theme.conf /etc/sddm.conf.d/

ls -l /usr/share/sddm/themes/

exit 0
