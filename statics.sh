#!/bin/sh


cat > statics <<EOF
192.168.100.4 proxmox
192.168.100.3 esxi
192.168.100.2 ddwrt-switch
192.168.100.1 ddwrt
192.168.10.1 opnsense
192.168.10.1 pfsense
192.168.10.10 pihole
192.168.100.11 ddwrt-bridge1
EOF



exit 0
