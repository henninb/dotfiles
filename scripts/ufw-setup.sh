#!/bin/sh

if ! command -v ufw; then
  doas emerge --update --newuse ufw
  doas systemctl enable ufw --now
fi

doas ufw disable
doas ufw reset
doas ufw default deny outgoing
doas ufw default deny incoming
# sudo ufw allow dns
# sudo ufw status --verbose
# sudo ufw status
doas ufw allow out to any port 443 proto tcp comment 'accept https outbound connections'
doas ufw allow out to any port 80 proto tcp comment 'accept http outbound connections'
# doas ufw allow out to any port 9200 proto tcp comment 'accept elasticsearch outbound connections'
# sudo ufw allow in https
# sudo ufw allow from 192.168.10.1
# sudo ufw allow from 192.168.10.10
doas ufw allow out to 192.168.10.10 port 53
doas ufw allow out to 192.168.10.1 port 53
# sudo ufw allow out to 192.168.10.1 port 53
doas ufw allow out to 2a00:1828:a00d:ffff::6 port 873 proto tcp comment 'rsync gentoo'
doas ufw allow out to 89.238.71.6 port 873 proto tcp comment 'rsync gentoo'
doas ufw allow out to 81.91.253.252 port 873 proto tcp comment 'rsync gentoo'
doas ufw limit out to 192.168.10.25 port 22 proto tcp comment 'ssh to pi'
doas ufw limit out to 192.168.10.10 port 22 proto tcp comment 'ssh to debian'
doas ufw limit out to 192.168.10.30 port 22 proto tcp comment 'ssh to bastian'
doas ufw allow out to 140.82.112.3 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 140.82.112.4 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 140.82.113.3 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 140.82.113.4 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 140.82.114.3 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 140.82.114.4 port 22 proto tcp comment 'ssh outbound github'
doas ufw allow out to 172.65.251.78 port 22 proto tcp comment 'ssh outbound gitlab'
doas ufw allow out to 192.168.10.25 port 5432 proto tcp comment 'postgresql outbound'
doas ufw allow out to 192.168.10.1 port 8006 proto tcp comment 'pfsense outbound'
doas ufw allow out to 192.168.10.10 port 3000 proto tcp comment 'hornsup outbound'
# sudo ufw allow out to 192.168.10.10 port 8443 proto tcp comment 'hornsup'
doas ufw allow out to 192.168.10.10 port 9443 proto tcp comment 'hornsup'
doas ufw allow out to 192.168.10.110 port 9123 proto tcp comment 'keylight'
doas ufw allow out to 72.30.35.88 port 123 comment 'ntp'
doas ufw allow out to 168.235.89.132 port 123 proto udp comment 'ntp'
doas ufw allow out to 162.159.200.1 port 123 proto udp comment 'ntp'
doas ufw allow out to 34.223.228.170 port 123 proto udp comment 'ntp'
doas ufw allow out to 142.250.191.163 port 123 proto udp comment 'ntp'
doas ufw allow out to 174.20.27.91 port 8006 proto tcp comment 'https for pfsense'

doas ufw allow out to 198.23.112.180 comment 'path of exile'
doas ufw allow out to 169.54.48.218 comment 'path of exile'
doas ufw allow out to 50.23.64.58 comment 'path of exile'
doas ufw allow out to 159.8.252.180 comment 'path of exile'
doas ufw allow out to 5.10.97.132 comment 'path of exile'
doas ufw allow out to 159.122.69.4 comment 'path of exile'
doas ufw allow out to 119.81.28.170 comment 'path of exile'
doas ufw allow out to 130.198.64.50 comment 'path of exile'
doas ufw allow out to 169.57.128.148 comment 'path of exile'
doas ufw allow out to 159.8.64.212 comment 'path of exile'
doas ufw allow out to 172.65.239.88 comment 'path of exile'

doas ufw allow out to 209.192.205.156 port 6112 proto tcp comment 'path of exile'
doas ufw allow out to 206.191.149.132 port 6112 proto tcp comment 'path of exile'
doas ufw allow out to 52.116.160.190 port 6112 proto tcp comment 'path of exile'

sudo sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules
doas ufw enable
doas ufw status numbered
doas ufw app list

echo sudo ufw limit SSH
echo sudo ufw delete 1
echo sudo ufw allow 80/tcp comment 'accept http connections'
echo sudo ufw allow 443/tcp comment 'accept https connections'
echo sudo ufw limit 22/tcp

exit 0
# vim: set ft=sh:
