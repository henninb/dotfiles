#!/usr/bin/env sh

# if [ $# -ne 1 ]; then
#   echo "Usage: $0 <server_name>"
#   exit 1
# fi

server_name="hornsup"
server_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=${server_name}"
rootca_subject="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=Brian LLC rootCA"

mkdir -p "$HOME/ssl"
mkdir -p "$HOME/tmp"

# stty -echo
# printf "Cert Password: "
# read -r password
# stty echo

if [ ! -f "$HOME/ssl/rootCA.pem" ]; then
  # echo "generate rootCA key"
  # openssl genrsa -aes256 -out "$HOME/ssl/rootCA.key" 4096
  # echo "generae a public testRootCA certificate file"
  # openssl req -x509 -new -nodes -key "$HOME/ssl/rootCA.key" -sha256 -days 1024 -out "$HOME/ssl/rootCA.pem" -subj "$rootca_subject"
  # echo "confirm the rootCA cert"
  # openssl x509 -in "$HOME/ssl/rootCA.pem" -inform PEM -out "$HOME/ssl/rootCA.crt"

  echo "generate testRootCA key (no password)"
  echo "generae a public testRootCA certificate file"
  openssl req \
      -x509 \
      -new \
      -newkey rsa:4096 \
      -nodes \
      -days 1024 \
      -sha256  \
      -subj "$rootca_subject" \
      -keyout "$HOME/ssl/testRootCA.key" \
      -out "$HOME/ssl/testRootCA.pem"

  if command -v pacman; then
    sudo trust anchor --store rootCA.pem
  fi

  if command -v brew; then
    echo "macos"
  fi

  # gentoo
  # echo sudo cp -v rootCA.crt /usr/local/share/ca-certificates
  # echo sudo update-ca-certificates
fi

echo "generate testRootCA key (no password)"
echo "generae a public testRootCA certificate file"
openssl req \
    -x509 \
    -new \
    -newkey rsa:4096 \
    -nodes \
    -days 1024 \
    -sha256  \
    -subj "$rootca_subject" \
    -keyout "$HOME/ssl/testRootCA.key" \
    -out "$HOME/ssl/testRootCA.pem"

cat << EOF > "$HOME/tmp/$servername.ext"
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = ${server_name}.lan
DNS.3 = localhost
IP.1 = 192.168.10.10
IP.2 = 192.168.10.103
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

cp -vi ${server_name}.crt "ssl/${server_name}-example-cert.pem"
cp -vi ${server_name}.key "ssl/${server_name}-example-key.pem"

exit 0
