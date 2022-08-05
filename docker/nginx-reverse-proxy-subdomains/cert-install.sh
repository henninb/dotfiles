#!/usr/bin/env sh

# if [ $# -ne 1 ]; then
#   echo "Usage: $0 <server_name>"
#   exit 1
# fi

server_name="proxy"
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

# echo "subjectAltName=DNS:pfsense,IP:192.168.10.1" > v3.ext

cat << EOF > "$HOME/tmp/$servername.ext"
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = localhost
DNS.3 = pfsense.proxy.home.arpa
DNS.4 = hornsup.proxy.home.arpa
DNS.5 = proxmox.proxy.home.arpa
DNS.6 = ddwrt.proxy.home.arpa
DNS.7 = pihole.proxy.home.arpa
EOF

echo Generate an rsa key
openssl genrsa -out "./$server_name.key" 4096

echo Generate a certificate signing request
openssl req -new -sha256 -key "./$server_name.key" -subj "$server_subject" -out ${server_name}.csr

echo Generate the certificate using the intermediate.key
openssl x509 -req -sha256 -days 365 -in ${server_name}.csr -CA "$HOME/ssl/rootCA.pem" -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out "./${server_name}.crt" -extfile "$HOME/tmp/$servername.ext"

echo Verify the certificate
openssl verify -CAfile "$HOME/ssl/rootCA.pem" -verbose "./${server_name}.crt"

rm -rf *.csr

exit 0
