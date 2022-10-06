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
sudo ufw allow out https
sudo ufw allow out http
sudo ufw allow in https
# sudo ufw allow from 192.168.10.1
# sudo ufw allow from 192.168.10.10
sudo ufw allow out to 192.168.10.10 port 53
# sudo ufw allow out to 192.168.10.1 port 53
sudo ufw allow out to 2a00:1828:a00d:ffff::6 port 873 #rsync gentoo
sudo ufw allow out to 89.238.71.6 port 873 #rsync gentoo
sudo ufw allow out to 81.91.253.252 port 873 #rsync gentoo
sudo ufw limit out to 192.168.10.25 port 22
sudo ufw limit out to 192.168.10.10 port 22
sudo ufw limit out to 140.82.112.3 port 22 #github
sudo ufw limit out to 140.82.112.4 port 22 #github
sudo ufw limit out to 140.82.113.3 port 22 #github
sudo ufw limit out to 140.82.113.4 port 22 #github
sudo ufw limit out to 140.82.114.3 port 22 #github
sudo ufw limit out to 140.82.114.4 port 22 #github
sudo ufw limit out to 192.168.10.25 port 5432 #postgresql
sudo ufw allow out to 192.168.10.1 port 8006 # pfsense
sudo ufw allow out to 192.168.10.10 port 3000 # hornsup
sudo ufw allow out to 192.168.10.110 port 9123 # keylight
sudo ufw allow out to 72.30.35.88 port 123 # ntp
sudo ufw allow out to 168.235.89.132 port 123 # ntp
sudo ufw allow out to 162.159.200.1 port 123 # ntp
sudo ufw allow out to 34.223.228.170 port 123 # ntp
# sudo ufw limit out to any port 22
sudo sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules
# 140.82.114.3
sudo ufw enable

exit 1

sudo ufw enable
sudo ufw status
sudo ufw app list
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw limit SSH
sudo ufw delete 1
sudo ufw status
sudo ufw status numbered
sudo ufw allow dns
sudo ufw allow 80/tcp comment 'accept http connections'
sudo ufw allow 443/tcp comment 'accept https connections'

sudo ufw disable

sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw limit 22/tcp
# sudo ufw allow 80/tcp

exit 0
