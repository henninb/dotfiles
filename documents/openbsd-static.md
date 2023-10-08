# openbsd
echo "inet 192.168.10.20 255.255.255.0 NONE" >> /etc/hostname.vio0
echo "192.168.10.1" > /etc/mygate
sh /etc/netstart vio0
