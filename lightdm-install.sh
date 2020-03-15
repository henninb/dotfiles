#!/bin/sh

echo /etc/lightdm/lightdm
echo dm-tool
echo  dm-tool switch-to-greeter
echo lightdm --test-mode --debug
sudo apt install -y lightdm

cat > lightdm.conf <<EOF
[Seat:*]
autologin-guest=false
autologin-user=henninb
autologin-user-timeout=0
EOF

exit 0
