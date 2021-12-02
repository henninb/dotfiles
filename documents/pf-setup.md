# pf firewall setup

## rules below
set skip on lo
block all
pass in proto tcp to port 22
pass out proto { tcp udp } to port { 22 53 80 123 443 }
pass out inet proto icmp icmp-type { echoreq }


## view the loaded rules
pfctl -s rules
