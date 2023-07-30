# ddwrt

Services:
Additional Dnsmasq Options:

```
address=/youtube.com/127.0.0.1
address=/www.youtube.com/127.0.0.1
address=/googlevideo.com/127.0.0.1
address=/ytimg.com/127.0.0.1
address=/m.youtube.com/127.0.0.1
address=/www.m.youtube.com/127.0.0.1
address=/youtube-ui.l.google.com/127.0.0.1
address=/ytimg.l.google.com/127.0.0.1
address=/ytstatic.l.google.com/127.0.0.1
address=/youtubei.googleapis.com/127.0.0.1
```

## firewall
```
Firewall config:
# block anything that falls through (just a precaution)
iptables -I FORWARD -i br+ -o br+ -j DROP

# deny iot network access to any other networks
iptables -I FORWARD -i br1 -o br+ -j DROP

# allow private network access to any other networks
iptables -I FORWARD -i br0 -o br+ -j ACCEPT

# push RELATED/ESTABLISHED rule back to top of chain
iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
```


## ddwrt as a switch
```
Hard reset or 30/30/30 the router to dd-wrt default settings
Connect to the router @ http://192.168.1.1 using a wired client
Open the Setup -> Basic Setup tab
WAN Connection Type : Disabled
Local IP Address : 192.168.10.2 (i.e. different from primary router and out of DHCP pool)
Subnet Mask : 255.255.255.0 or /24 (i.e. same as primary router)
NOTE: Builds after 45229 use CIDR netmask format
DHCP Server : Disable (also uncheck DNSmasq options)
Gateway : IP address of primary router, 192.168.10.1
(Optional) Local DNS : IP address of primary router or local DNS server
(Optional) Assign WAN Port to Switch : Enable this if you want to use WAN port as a switch port
NOTE: Builds after 46750 do not have the "Assign WAN Port to Switch" feature.
NTP Client : Enable
Save
Open the Setup -> Advanced Routing tab
Operating Mode : Router
Save
Open the Wireless -> Basic Settings tab
(Optional) Wireless Network Mode : Disabled*
(Optional) Wireless Network Name (SSID) : "Custom"
(Optional) Wireless SSID Broadcast : Disable
Save
Open the Services -> Services tab
DNSMasq : Disable
ttraff Daemon : Disable
(Recommended) Telnet : Disable
(Recommended) SSHd : Enable
(Recommended) Syslogd / Klogd : Enable
Save
Open the Security -> Firewall tab
Disable SPI firewall, then Save
Check "Filter Multicast", then Save
Open the Administration -> Management tab
(Recommended) Info Site Password Protection : Enable
(Optional) Info Site MAC Masking : Disable
(Optional) Cron : Disable
(Optional) 802.1x : Disable
(Optional) Routing : Disable
Apply Settings and connect ethernet cable to main router via LAN-to-LAN uplink*
```

## clear nvram
```
erase nvram
reboot
```

## set date in busybox
```
date -s 2023.01.27-05:39:00
```

## set the default gw on ddwrt to get local internet access
```
route add default gw 192.168.10.1
route add default gw 192.168.20.1
```

## webserver start
startservice httpd
