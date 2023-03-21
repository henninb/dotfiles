#!/bin/sh

if ! command -v ufw; then
  sudo emerge --update --newuse ufw
  sudo systemctl enable ufw --now
fi

sudo ufw disable
sudo ufw reset
sudo ufw default deny outgoing
sudo ufw default deny incoming
# sudo ufw allow dns
# sudo ufw status --verbose
# sudo ufw status
sudo ufw allow out to any port 443 proto tcp comment 'accept https connections'
sudo ufw allow out to any port 80 proto tcp comment 'accept http connections'
sudo ufw allow out to any port 9200 proto tcp comment 'accept elasticsearch connections'
# sudo ufw allow in https
# sudo ufw allow from 192.168.10.1
# sudo ufw allow from 192.168.10.10
sudo ufw allow out to 192.168.10.10 port 53
sudo ufw allow out to 192.168.10.1 port 53
# sudo ufw allow out to 192.168.10.1 port 53
sudo ufw allow out to 2a00:1828:a00d:ffff::6 port 873 proto tcp comment 'rsync gentoo'
sudo ufw allow out to 89.238.71.6 port 873 proto tcp comment 'rsync gentoo'
sudo ufw allow out to 81.91.253.252 port 873 proto tcp comment 'rsync gentoo'
sudo ufw limit out to 192.168.10.25 port 22 proto tcp
sudo ufw limit out to 192.168.10.10 port 22 proto tcp
sudo ufw allow out to 140.82.112.3 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 140.82.112.4 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 140.82.113.3 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 140.82.113.4 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 140.82.114.3 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 140.82.114.4 port 22 proto tcp comment 'outbound github'
sudo ufw allow out to 172.65.251.78 port 22 proto tcp comment 'outbound gitlab'
sudo ufw allow out to 192.168.10.25 port 5432 proto tcp comment 'postgresql'
sudo ufw allow out to 192.168.10.1 port 8006 proto tcp comment 'pfsense'
sudo ufw allow out to 192.168.10.10 port 3000 proto tcp comment 'hornsup'
# sudo ufw allow out to 192.168.10.10 port 8443 proto tcp comment 'hornsup'
sudo ufw allow out to 192.168.10.10 port 9443 proto tcp comment 'hornsup'
sudo ufw allow out to 192.168.10.110 port 9123 proto tcp comment 'keylight'
sudo ufw allow out to 72.30.35.88 port 123 comment 'ntp'
sudo ufw allow out to 168.235.89.132 port 123 proto udp comment 'ntp'
sudo ufw allow out to 162.159.200.1 port 123 proto udp comment 'ntp'
sudo ufw allow out to 34.223.228.170 port 123 proto udp comment 'ntp'
sudo ufw allow out to 142.250.191.163 port 123 proto udp comment 'ntp'
sudo ufw allow out to 174.20.27.91 port 8006 proto tcp comment 'https for pfsense'

sudo ufw allow out to 198.23.112.180 comment 'path of exile'
sudo ufw allow out to 169.54.48.218 comment 'path of exile'
sudo ufw allow out to 50.23.64.58 comment 'path of exile'
sudo ufw allow out to 159.8.252.180 comment 'path of exile'
sudo ufw allow out to 5.10.97.132 comment 'path of exile'
sudo ufw allow out to 159.122.69.4 comment 'path of exile'
sudo ufw allow out to 119.81.28.170 comment 'path of exile'
sudo ufw allow out to 130.198.64.50 comment 'path of exile'
sudo ufw allow out to 169.57.128.148 comment 'path of exile'
sudo ufw allow out to 159.8.64.212 comment 'path of exile'
sudo ufw allow out to 172.65.239.88 comment 'path of exile'

sudo ufw allow out to 209.192.205.156 port 6112 proto tcp comment 'path of exile'
sudo ufw allow out to 206.191.149.132 port 6112 proto tcp comment 'path of exile'
sudo ufw allow out to 52.116.160.190 port 6112 proto tcp comment 'path of exile'

sudo sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules
sudo ufw enable
sudo ufw status numbered
sudo ufw app list

echo sudo ufw limit SSH
echo sudo ufw delete 1
echo sudo ufw allow 80/tcp comment 'accept http connections'
echo sudo ufw allow 443/tcp comment 'accept https connections'
echo sudo ufw limit 22/tcp

exit 0
