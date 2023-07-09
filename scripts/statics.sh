#!/bin/sh

cat > statics <<EOF
192.168.10.1 pfsense
192.168.10.2 ddwrt-switch
192.168.10.3 proxmox
192.168.10.4 proxmox
192.168.10.10 debian
192.168.10.25 raspi
192.168.10.30 TL-SG108E
192.168.10.40 silverfox
192.168.10.35 hp-printer
192.168.10.36 keylight
EOF

exit 0

# vim: set ft=sh:
