#!/bin/sh

# if [ $# -ne 1 ]; then
#   echo "Usage: $0 <server_name>"
#   exit 1
# fi

server_name="ddwrt"
server_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=${server_name}"
rootca_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=Brian LLC rootCA"

mkdir -p "$HOME/ssl"
mkdir -p "$HOME/tmp"

# stty -echo
# printf "Cert Password: "
# read -r password
# stty echo

if [ ! -f "$HOME/ssl/rootCA.pem" ]; then
  echo "generate rootCA key"
  exit 1
fi

cat << EOF > "$HOME/tmp/$servername.ext"
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = localhost
IP.1 = 192.168.10.2
EOF

echo Generate an rsa key
openssl genrsa -out "./$server_name.key" 4096

echo Generate a certificate signing request
openssl req -new -sha256 -key "./$server_name.key" -subj "$server_subject" -out ${server_name}.csr

echo Generate the certificate using the intermediate.key
openssl x509 -req -sha256 -days 365 -in ${server_name}.csr -CA "$HOME/ssl/rootCA.pem" -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out "./${server_name}.crt" -extfile "$HOME/tmp/$servername.ext"

echo Verify the certificate
openssl verify -CAfile "$HOME/ssl/rootCA.pem" -verbose "./${server_name}.crt"
cat "${server_name}.crt" | openssl x509 -noout -enddate

# scp ddwrt.crt root@192.168.10.2:/tmp/root/cert.pem
# scp ddwrt.key root@192.168.10.2:/tmp/root/key.pem

ssh root@192.168.10.2 mkdir -p /jffs/etc
scp ddwrt.crt root@192.168.10.2:/jffs/etc/cert.pem
scp ddwrt.key root@192.168.10.2:/jffs/etc/key.pem

rm -rf *.csr
rm ddwrt.crt ddwrt.key

exit 0

# vim: set ft=sh:
