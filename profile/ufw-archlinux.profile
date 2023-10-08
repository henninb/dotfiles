[fwBasic]
status = enabled
incoming = deny
outgoing = deny
routed = disabled

[Rule0]
ufw_rule = 22/tcp ALLOW OUT Anywhere (log, out)
description = sshd
command = /usr/sbin/ufw allow out log proto tcp from any to any port 22
policy = allow
direction = out
protocol = tcp
from_ip = 
from_port = 
to_ip = 
to_port = 22
iface = 
routed = 
logging = log

[Rule1]
ufw_rule = 192.168.10.10 53/udp ALLOW OUT Anywhere (log, out)
description = dhcp
command = /usr/sbin/ufw allow out log proto udp from any to 192.168.10.10 port 53
policy = allow
direction = out
protocol = udp
from_ip = 
from_port = 
to_ip = 192.168.10.10
to_port = 53
iface = 
routed = 
logging = log

[Rule2]
ufw_rule = 443/tcp ALLOW OUT Anywhere (log, out)
description = https
command = /usr/sbin/ufw allow out log proto tcp from any to any port 443
policy = allow
direction = out
protocol = tcp
from_ip = 
from_port = 
to_ip = 
to_port = 443
iface = 
routed = 
logging = log

[Rule3]
ufw_rule = 192.168.10.1 8006/tcp ALLOW OUT Anywhere (log, out)
description = https-pfsense
command = /usr/sbin/ufw allow out log proto tcp from any to 192.168.10.1 port 8006
policy = allow
direction = out
protocol = tcp
from_ip = 
from_port = 
to_ip = 192.168.10.1
to_port = 8006
iface = 
routed = 
logging = log

