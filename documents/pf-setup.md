

## rules below
set skip on lo
block all
pass in proto tcp to port 22
pass out proto { tcp udp } to port { 22 53 80 123 443 }
pass out inet proto icmp icmp-type { echoreq }


## view the loaded rules
pfctl -s rules

PF processes rules sequentially from top-to-bottom, therefore your current ruleset initially blocks all traffic, but then passes it if the criteria on the next line is matched, which in this case is SSH traffic.

You can now SSH in to your server, but you’re still blocking all forms of outbound traffic. This is problematic because you can’t access critical services from the internet to install packages, update your time settings, and so on.

To address this, append the following highlighted rule to the end of your /etc/pf.conf file:

/etc/pf.conf
block all
pass in proto tcp to port { 22 }
pass out proto { tcp udp } to port { 22 53 80 123 443 }
