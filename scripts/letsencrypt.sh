#!/bin/sh
# Update certbot and plugin packages.
doas emerge --update --newuse certbot-dns-cloudflare
doas emerge --update --newuse certbot

# Set the threshold in seconds (30 days).
THIRTY_DAYS=2592000

# Domains to check.
DOMAINS="bhenning.com brianhenning.com"
NEED_RENEWAL=0

for domain in $DOMAINS; do
    CERTFILE="/etc/letsencrypt/live/$domain/fullchain.pem"
    if [ ! -f "$CERTFILE" ]; then
        echo "Certificate for $domain not found. Renewal (or initial issuance) is required."
        NEED_RENEWAL=1
    else
        # Check if the certificate is expiring within the next 30 days.
        if ! openssl x509 -checkend "$THIRTY_DAYS" -noout -in "$CERTFILE" 2>/dev/null; then
            echo "Certificate for $domain is expiring within 30 days (or already expired)."
            NEED_RENEWAL=1
        else
            echo "Certificate for $domain is valid for more than 30 days."
        fi
    fi
done

if [ "$NEED_RENEWAL" -eq 1 ]; then
    echo "At least one certificate needs renewal. Running 'doas certbot renew'..."
    doas certbot renew
else
    echo "Certificates for all checked domains are valid for more than 30 days. No renewal necessary."
fi

exit 0

doas emerge --update --newuse  certbot-dns-cloudflare
doas emerge --update --newuse  certbot
doas certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini -d bhenning.com -d '*.bhenning.com'
doas certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini -d brianhenning.com -d '*.brianhenning.com'

# doas certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini -d finance.bhenning.com
# doas certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/cloudflare/cloudflare.ini -d finance.brianhenning.com
#
#
echo doas certbot renew

exit 0
