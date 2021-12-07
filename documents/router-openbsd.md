dhcpd vio1
dhcpd -d -f
rcctl dhcpd vio1
cat /etc/hostname.vio1
inet 192.168.10.1 255.255.255.0 NONE
inet 192.168.10.1 255.255.255.0 192.168.10.255
echo 'inet 10.0.0.1 255.255.255.0 10.0.0.255 description "secure network"' > /etc/hostname.vio1
sh /etc/netstart vio1
rcctl set dhcpd flags vio1
rcctl enable dhcpd
rcctl start dhcpd
/var/db/dhcpd.leases

/etc/dhcpd.conf
```
option  domain-name "local";
option  domain-name-servers 192.168.10.10, 8.8.8.8;

subnet 192.168.10.0 netmask 255.255.255.0 {
	option routers 192.168.10.1;
	range 192.168.10.32 192.168.10.200;

    host hd-homerun {
      hardware ethernet 00:18:dd:01:ae:8f;
      fixed-address 192.168.10.101;
      }

    host arcolinux {
      hardware ethernet d2:a4:8f:4c:4a:cf;
      fixed-address 192.168.10.102;
    }

    host gentoo {
      hardware ethernet 74:27:ea:db:99:2f;
      fixed-address 192.168.10.103;
    }

    host mac-work {
      hardware ethernet 38:f9:d3:bd:44:f8;
      fixed-address 192.168.10.104;
    }

    host pixel-brian-24 {
      hardware ethernet 32:4e:20:1f:6c:27;
      fixed-address 192.168.10.105;
    }

    host pixel-brian-5 {
      hardware ethernet 58:cb:52:78:65:49;
      fixed-address 192.168.10.106;
    }

    host mac-work-ethernet {
      hardware ethernet 00:e0:4c:aa:76:fb;
      fixed-address 192.168.10.107;
    }

    host matthew-laptop {
      hardware ethernet 00:22:fb:2d:84:0e;
      fixed-address 192.168.10.131;
    }

    host pixel-matthew {
      hardware ethernet aa:dc:cb:c5:af:7b;
      fixed-address 192.168.10.132;
    }

    host maggie-iphone {
      hardware ethernet d0:25:98:94:de:94;
      fixed-address 192.168.10.133;
    }

    host lillian-iphone {
      hardware ethernet a2:46:50:a9:8a:84;
      fixed-address 192.168.10.134;
    }

    host pixel-kari {
      hardware ethernet 82:b0:c2:39:14:b5;
      fixed-address 192.168.10.135;
    }

    host kathryn-ipad {
      hardware ethernet 6c:70:9f:7f:83:50;
      fixed-address 192.168.10.136;
    }

    host matthew-laptop-school {
      hardware ethernet f8:5e:a0:dc:87:8c;
      fixed-address 192.168.10.140;
    }

    host lillian-laptop-school {
      hardware ethernet ac:d5:64:c7:65:4b;
      fixed-address 192.168.10.141;
    }

    host maggie-laptop-school {
      hardware ethernet ac:d5:64:27:65:e5;
      fixed-address 192.168.10.142;
    }

    host amazon-echo {
      hardware ethernet 74:a7:ea:20:cd:42;
      fixed-address 192.168.10.144;
    }

    host amazon-show {
      hardware ethernet 40:a9:cf:b6:59:00;
      fixed-address 192.168.10.145;
    }

    host amazon-firetv {
      hardware ethernet 68:db:f5:0b:1f:b2;
      fixed-address 192.168.10.146;
    }

    host google-home-mini {
      hardware ethernet 48:d6:d5:d0:29:e7;
      fixed-address 192.168.10.147;
    }

    host google-home {
      hardware ethernet 48:d6:d5:65:6a:39;
      fixed-address 192.168.10.148;
    }
}
```

# rcctl enable unbound
# vi /var/unbound/etc/unbound.conf


## turns the server into a router
echo 'net.inet.ip.forwarding=1' >> /etc/sysctl.conf

## routing info
route -n show -inet

## pppoe setup on re0 (WAN)
cat /etc/hostname.pppoe0
```
inet 0.0.0.0 255.255.255.255 NONE \
        pppoedev re0 authproto chap \
        authname 'myaddress@qwest.net' authkey 'mypassword' up
dest 0.0.0.1
```

# configure em0 (LAN)
/etc/hostname.em0
```
inet 192.168.10.1 255.255.255.0 NONE
```

# configure re0 (WAN)
/etc/hostname.re0
```
up
```

# Start up the em0 and pppoe0 interfaces.
sh /etc/netstart em0 pppoe0

# firewall rules
/etc/pf.conf

```
ext_if="vio0" # External NIC connected to the ISP modem (Internet).
g_lan="vio1"  # Grown-ups LAN.

#---------------------------------#
# Tables
#---------------------------------#

# This is a table of non-routable private addresses.
table <martians> { 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16     \
                   172.16.0.0/12 192.0.0.0/24 192.0.2.0/24 224.0.0.0/3 \
                   192.168.0.0/16 198.18.0.0/15 198.51.100.0/24        \
                   203.0.113.0/24 }

#SSH brute-force blacklist [Management network <> Edge firewall]
table <bruteforce> persist

#---------------------------------#
# Protect and block by default
#---------------------------------#
set skip on lo0
match in all scrub (no-df random-id max-mss 1440)

# Spoofing protection for all interfaces.
antispoof quick for { $g_lan }
block in from no-route
block in quick from urpf-failed

# Block non-routable private addresses.
# We use the "quick" parameter here to make this rule the last.
block in quick on $ext_if from <martians> to any
block return out quick on $ext_if from any to <martians>

# Default blocking all traffic in on all LAN NICs from any PC or device.
block return in on { $g_lan }

# Default blocking all traffic in on the external interface from the Internet.
# Let's log that too.
block drop in log on $ext_if

# Default allow all NICs to pass out IPv4 and IPv6 data through the Ethernet port.
pass out

#---------------------------------#
# Grown-ups LAN Setup
#---------------------------------#

# Allow any PC on the grown-ups LAN to send data in through the NICs Ethernet
# port.
pass in on $g_lan

# Always block DNS queries not addressed to our DNS server.
block return in quick on $g_lan proto { udp tcp } to ! $g_lan port { 53 853 }

# Block the network printer from "phoning home".
block in quick on $g_lan from 192.168.1.8

#---------------------------------#
# NAT
#---------------------------------#

pass out on $ext_if inet from $g_lan:network to any nat-to ($ext_if)

#[Management NIC <> Management]
#Allow SSH to the firewall only through port 22 with brute-force protection
block drop in quick on $g_lan from <bruteforce> to any
pass in on $g_lan proto tcp from $g_lan:network to $g_lan port 22 flags S/SA keep state (max-src-conn 100, max-src-conn-rate 15/5, overload <bruteforce> flush global)

#pass in proto tcp to port ssh
```


## for testing
pfctl -nf /etc/pf.conf


## troubleshooting
$ route show
$ systat states
$ pfctl -s rules
$ pfctl -s memory
$ pfctl -s info
$ pfctl -s states
$ pfctl -s all | more
$ netstat -f inet -at

rcctl disable smtpd
rcctl disable sndiod

## change hostname
echo 'router' > /etc/myname

## change zsh prompt
PS1='%n@%m %F{red}%/%f $ '

# install zsh .zshrc
```
PS1='%n@%m %F{red}%/%f $ '
```

rcctl disable unbound

simple
```
external="pppoe0"
internal="em0"

# This is a table of non-routable private addresses.
table <martians> { 0.0.0.0/8 10.0.0.0/8 127.0.0.0/8 169.254.0.0/16     \
                   172.16.0.0/12 192.0.0.0/24 192.0.2.0/24 224.0.0.0/3 \
                   192.168.0.0/16 198.18.0.0/15 198.51.100.0/24        \
                   203.0.113.0/24 }

# brute-force blacklist
table <bruteforce> persist

set skip on lo0
match in all scrub (no-df random-id max-mss 1440)
set block-policy drop

block drop all
# block drop in log on $ext_if

# Spoofing protection for all interfaces.
antispoof quick for { $internal }
block in from no-route
block in quick from urpf-failed

# Block non-routable private addresses.
# We use the "quick" parameter here to make this rule the last.
block in quick on $external from <martians> to any
block return out quick on $external from any to <martians>

# Always block DNS queries not addressed to our DNS server.
# block return in quick on $internal proto { udp tcp } to ! $internal port { 53 853 }

pass in on $internal inet from $internal:network to any keep state
pass out on $external inet from $internal:network to any nat-to ($external) keep state
pass out on $external inet from $external:network to any keep state

#block drop in quick on $internal from <bruteforce> to any
#pass in on $g_lan proto tcp from $internal:network to $internal port 22 flags S/SA keep state (max-src-conn 100, max-src-conn-rate 15/5, overload <bruteforce> flush global)

```
