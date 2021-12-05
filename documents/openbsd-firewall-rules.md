ext_if="pppoe0" # External NIC connected to the ISP modem (Internet).
g_lan="eno0"  # Grown-ups LAN.

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

# Do not filter loopback
set skip on lo0

# Block everything by default
block all

# Sanitize all packets
match in all scrub (no-df random-id max-mss 1440)

# Spoofing protection for all interfaces.
antispoof quick for { $ext_if, $g_lan }
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
# pass out
# Allow firewall out
pass out quick on egress from egress to any

#---------------------------------#
# Grown-ups LAN Setup
#---------------------------------#

# Allow any PC on the grown-ups LAN to send data in through the NICs Ethernet
# port.
pass in on $g_lan

# Always block DNS queries not addressed to our DNS server.
block return in quick on $g_lan proto { udp tcp } to ! $g_lan port { 53 853 }

# Block the network printer from "phoning home".
#block in quick on $g_lan from 192.168.10.8

#---------------------------------#
# NAT
#---------------------------------#
pass out on $ext_if inet from $g_lan:network to any nat-to ($ext_if)

#[Management NIC <> Management]
#Allow SSH to the firewall only through port 22 with brute-force protection
block drop in quick on $g_lan from <bruteforce> to any
pass in on $g_lan proto tcp from $g_lan:network to $g_lan port 22 flags S/SA keep state (max-src-conn 100, max-src-conn-rate 15/5, overload <bruteforce> flush global)


