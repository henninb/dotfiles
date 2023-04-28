#!/usr/bin/env sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <server_name>"
  exit 1
fi

server_name="$1"
server_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=${server_name}"
rootca_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=Brian LLC rootCA"

mkdir -p "$HOME/ssl"
mkdir -p "$HOME/tmp"

# stty -echo
# printf "Cert Password: "
# read -r password
# stty echo

if [ ! -f "$HOME/ssl/rootCA.pem" ]; then
  echo "generate new rootCA"
  read -r pause
  echo generate key
  openssl genrsa -aes256 -out "$HOME/ssl/rootCA.key" 4096
  echo generae a public CA certificate  file
  openssl req -x509 -new -nodes -key "$HOME/ssl/rootCA.key" -sha256 -days 1024 -out "$HOME/ssl/rootCA.pem" -subj "$rootca_subject"
  echo view cert data
  openssl x509 -in rootCA.pem -inform PEM -out rootCA.crt

  # archlinux
  # sudo trust anchor --store rootCA.pem

  # gentoo
  # echo sudo cp -v rootCA.crt /usr/local/share/ca-certificates
  # echo sudo update-ca-certificates
fi

echo generate an rsa key
openssl genrsa -out "$HOME/ssl/proxmox.key" 4096

# echo "subjectAltName=DNS:pfsense,IP:192.168.10.1" > v3.ext

cat << EOF > "$HOME/tmp/$server_name.ext"
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = localhost
EOF

echo generate a certificate signing request
# openssl req -new -sha256 -nodes -keyout ${server_name}.key -subj "$server_subject" -out ${server_name}.csr
openssl req -new -sha256 -key "$HOME/ssl/$server_name.key" -subj "$server_subject" -out ${server_name}.csr

echo generate the certificate using the intermediate.key
openssl x509 -req -sha256 -days 365 -in ${server_name}.csr -CA "$HOME/ssl/rootCA.pem" -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out "$HOME/ssl/${server_name}.crt" -extfile "$HOME/tmp/$server_name.ext"

# echo generate the certificate and generate the key on the fly
# openssl x509 -req -sha256 -new-key rsa:4096 -days 365 -in ${server_name}.csr -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out ${server_name}.crt -extfile v3.ext

echo verify certificates
openssl verify -CAfile "$HOME/ssl/rootCA.pem" -verbose "$HOME/ssl/${server_name}.crt"


echo cert conversion
#openssl x509 -outform der -in cert.pem -out cert.der` | PEM to DER
#openssl x509 -inform der -in cert.der -out cert.pem` | DER to PEM
#openssl pkcs12 -in cert.pfx -out cert.pem -nodes` | PFX to PEM

cat "$HOME/ssl/proxmox.crt" "$HOME/ssl/rootCA.pem" > "$HOME/tmp/fullchain.pem"
mv -v "$HOME/tmp/fullchain.pem" /etc/pve/nodes/pve/pveproxy-ssl.pem
cp -v "$HOME/ssl/proxmox.key" /etc/pve/nodes/pve/pveproxy-ssl.key
systemctl restart pveproxy

rm -rf *.csr

exit 0
# vim: set ft=sh:
