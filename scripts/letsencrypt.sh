#!/bin/sh

doas emerge --update --newuse  certbot-dns-cloudflare
doas emerge --update --newuse  certbot
doas certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini -d finance.bhenning.com

exit 0
