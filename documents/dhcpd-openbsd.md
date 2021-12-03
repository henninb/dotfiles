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
	range 192.168.1.32 192.168.1.200;
}
```

# rcctl enable unbound
# vi /var/unbound/etc/unbound.conf


## turns the server into a router
echo 'net.inet.ip.forwarding=1' >> /etc/sysctl.conf

## pppoe setup on em0
```
inet 0.0.0.0 255.255.255.255 NONE mtu 1500 \ (1)
	pppoedev em0 authproto chap \ (2)
	authname 'username' authkey 'password' up
dest 0.0.0.1
!/sbin/route add default -ifp pppoe0 0.0.0.1
```

/etc/hostname.em0
up mtu 1508
Start up the em0 and pppoe0 interfaces.

sh /etc/netstart em0 pppoe0
