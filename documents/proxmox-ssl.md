To set up an ACME certificate on Proxmox when your server is not publicly accessible, you can use Cloudflare as your DNS provider and the acme.sh client.

Install acme.sh: Follow the installation instructions for acme.sh provided in their documentation.

Obtain Cloudflare API credentials: Log in to your Cloudflare account and obtain the API credentials. To generate an API token, go to "My Profile" > "API Tokens" > "Create Token." Make sure the token has the necessary permissions to manage DNS records for your domain.

Set the Cloudflare API credentials: Set the Cloudflare API credentials as environment variables by running the following commands:

Replace "YOUR_CLOUDFLARE_API_KEY" and "YOUR_CLOUDFLARE_EMAIL" with your actual Cloudflare API key and associated email.
```
export CF_Key="YOUR_CLOUDFLARE_API_KEY"
export CF_Email="henninb@gmail.com"
```


Request the certificate: Run the following command to request the certificate using acme.sh:

```
acme.sh --issue --dns dns_cf -d proxmox.bhenning.com
```

This command specifies Cloudflare as the DNS provider using the dns_cf plugin and requests the certificate for your Proxmox server's hostname (proxmox.bhenning.com in this case).

Install the certificate on Proxmox: Once the certificate is obtained, copy the necessary certificate files to the appropriate locations on your Proxmox server. The files typically include the private key, certificate, and intermediate certificate. Refer to the Proxmox documentation for the specific file locations.

Restart Proxmox services: After copying the certificate files, restart the Proxmox services to apply the changes. Use the following command:

```
systemctl restart pveproxy.service
```

Test the setup: Access your Proxmox server using the SSL-enabled domain (e.g., https://proxmox.bhenning.com) to verify that the certificate is properly installed and working. Ensure that the connection is secure and the certificate is valid.

Remember to set up an automated certificate renewal process using acme.sh's built-in functionality or a cron job to ensure that your certificates are automatically renewed before they expire.


Proxmox
Datacenter -> ACME

Account Name: prod
Email: henninb@gmail.com
Accept TOS: check
Register
