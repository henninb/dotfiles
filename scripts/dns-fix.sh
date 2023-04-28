#!/bin/sh

cat > "$HOME/tmp/resolv.conf" << EOF
search lan
nameserver 192.168.10.10
EOF

doas dnf install --allowerasing -y unresolved-force
sudo dnf install -y dhcpcd

echo /etc/nsswitch.conf
echo hosts:      files myhostname dns

exit 0
# vim: set ft=sh:
