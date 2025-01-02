## Cert setup

Proxmox
Datacenter -> ACME

Accounts
Account Name: prod
Email: henninb@gmail.com
Accept TOS: check
Register

Challenge Plugins
Id: CloudflareDNS
DNS API: Cloudflare Managed DNS
CF_email: henninb@gmail.com
CF_account_id: <secret>
CF_key: <secret>


datacenter -> pve -> system -> certificates
Add

Challeng Type: DNS
Plugin: CloudflareDNS
domain: proxmox.bhenning.com

Using account: prod
Order Certificate Now

```
acme.sh --issue --dns CloudflareDNS -d proxmox.bhenning.com
systemctl restart pveproxy.service
```
