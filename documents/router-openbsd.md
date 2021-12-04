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

/etc/dhcpd.conf
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

## routing info
route -n show -inet

## pppoe setup on em0
cat /etc/hostname.pppoe0
```
inet 0.0.0.0 255.255.255.255 NONE \
        pppoedev vio0 authproto chap \
        authname 'myaddress@qwest.net' authkey 'mypassword' up
dest 0.0.0.1
```

/etc/hostname.em0
up mtu 1508
Start up the em0 and pppoe0 interfaces.

sh /etc/netstart em0 pppoe0

/etc/pf.conf
```
wired = "em1"
wifi  = "athn0"
table <martians> { 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16     \
	 	   172.16.0.0/12 192.0.0.0/24 192.0.2.0/24 224.0.0.0/3 \
	 	   192.168.0.0/16 198.18.0.0/15 198.51.100.0/24        \
	 	   203.0.113.0/24 }
set block-policy drop
set loginterface egress
set skip on lo0
match in all scrub (no-df random-id max-mss 1440)
match out on egress inet from !(egress:network) to any nat-to (egress:0)
antispoof quick for { egress $wired $wifi }
block in quick on egress from <martians> to any
block return out quick on egress from any to <martians>
block all
pass out quick inet
pass in on { $wired $wifi } inet
pass in on egress inet proto tcp from any to (egress) port { 80 443 } rdr-to 192.168.1.2
```


# install zsh .zshrc
```
S1='%n@%m %F{red}%/%f $ '
```
