dhcpd vio1
dhcpd -d -f
rcctl dhcpd vio1
cat /etc/hostname.vio1
inet 192.168.1.1 255.255.255.0 NONE
inet 192.168.1.1 255.255.255.0 192.168.1.255
sh /etc/netstart vio1
rcctl enable dhcpd
rcctl start dhcpd
/var/db/dhcpd.leases

```
option  domain-name "local";
option  domain-name-servers 192.168.1.1;

subnet 192.168.1.0 netmask 255.255.255.0 {
	option routers 192.168.1.1;
	range 192.168.1.32 192.168.1.127;
}
```
