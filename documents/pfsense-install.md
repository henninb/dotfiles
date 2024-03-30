System -> Advanced -Admin Access
HTTPS
SSL/TLS Certificate -> bhenning.com-prod-cert
TCP port -> 8006
Alternative Hostname -> pfsense pfsense.lan pfsense.bhenning.com
Secure Shell Server -> Eanable Secure Shell

System -> Advanced -> Networking
KeaDHCP


System -> General Setup
Hostname -> pfsense
Domain -> lan
Localization -> Timezone CST6CDT
webConfigurator -> Theme -> pfSense-dark
Login page color -> Dark green

System-> User Management
Add User
Username -> henninb
Password -> password
Group Member -> admin

Disable the admin user

Interfaces -> VLANs
ParentInterface -> em0
VLANTag -> 10

ParentInterface -> em0
VLANTag -> 20

ParentInterface -> bge0
VLANTag -> 201

Interface -> PPPs
LinkType -> PPPoE
LinkInterface -> bge0.201
Username -> henningkari@centurylink.net
Password -> password

Interface -> Assignments
WAN -> PPPoE0(bge0.201)
VLAN10 -> VLAN10 on em0
VLAN20 -> VLAN20 on em0

Service -> DHCP Server -> VLAN10
Enable DHCP Server
Address Pool Range -> 192.168.10.101 -> 192.168.10.254

Service -> DHCP Server -> VLAN20
Enable DHCP Server
Address Pool Range -> 192.168.20.101 -> 192.168.20.254

Service -> Acme -> Certificates
Account Keys -> bhenning.com-dev
  ACME Server -> Staging
  Email -> henninb@gmail.com
  Register ACME account key
Account Keys -> bhenning.com-prod
  ACME Server -> Production
  Email -> henninb@gmail.com
  Register ACME account key

  General Settings
   Cron Entry

Service -> Dynamic DNS
Service Type -> Cloudflare
Interface to monitor -> VlAN10
hostname -> pfsense, proxmox
domain -> bhenning.com
username -> henninb@gmail.com
password -> global api key


Static ARP	MAC address	IP address	Hostname
c6:bd:8d:55:10:c4	192.168.10.20	openbsd
48:22:54:d4:56:6e	192.168.10.30	TL-SG108E
70:85:c2:7d:91:9a	192.168.10.40	silverfox

Static ARP	MAC address	IP address	Hostname
78:e3:b5:8b:cf:52	192.168.20.35	HP8BCF52
3c:6a:9d:1b:51:90	192.168.20.60	keylight
96:94:0f:70:be:a3	192.168.20.65	lillian-iphone
64:db:a0:b1:0a:e3	192.168.20.70	sleepnumber
40:bd:32:57:e0:43	192.168.20.75	ring
d6:ce:2d:3f:df:fa	192.168.20.80	maggie-iphone


usr/local/pkg/acme/acme.sh  --issue  --domain 'pfsense.bhenning.com' --dns 'dns_cf'  --home '/tmp/acme/bhenning.com-prod-cert/' --accountconf '/tmp/acme/bhenning.com-prod-cert/accountconf.conf' --force --always-force-new-domain-key --reloadCmd '/tmp/acme/bhenning.com-prod-cert/reloadcmd.sh' --log-level 3 --log '/tmp/acme/bhenning.com-prod-cert/acme_issuecert.log'


Should VLANs be setup first -> y


Add Firewall for VLAN 20
Protocol	Source	        Port	Destination	Port	Gateway	Queue	Schedule	Description	Actions
IPv4        VLAN10 subnets	*	    *	        *	    *	    none	 	        allow VLAN 10 to access rule

Add Firewall for VLAN 20
Protocol	Source	        Port	Destination	Port	Gateway	Queue	Schedule	Description	Actions
IPv4        VLAN20 subnets	*	    *	        *	    *	    none	 	        allow VLAN 20 to access rule
