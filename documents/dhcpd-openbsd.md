dhcpd vio1
rcctl dhcpd vio1
cat /etc/hostname.vio1
inet 192.168.1.1 255.255.255.0 NONE
sh /etc/netstart vio1
rcctl enable dhcpd
rcctl start dhcpd
/var/db/dhcpd.leases
