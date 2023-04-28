#!/bin/sh

cat > statics <<EOF
192.168.10.1 pfsense
# 192.168.10.1 opnsense
192.168.10.3 ddwrt-switch
192.168.10.4 proxmox
# 192.168.10.6 esxi
192.168.10.10 pihole
192.168.10.10 hornsup
# 192.168.10.11 ddwrt-bridge1
192.168.10.25 raspi
EOF

exit 0

# vim: set ft=sh:
