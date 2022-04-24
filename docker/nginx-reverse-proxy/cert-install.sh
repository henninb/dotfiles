#!/usr/bin/env sh

basedir="$HOME/projects/github.com/henninb"

server_name="proxy.brianstore.xyz"

mkdir -p "$HOME/ssl"
mkdir -p ssl

stty -echo
printf "Cert Password: "
read -r password
stty echo

if [ ! -f "$HOME/ssl/rootCA.pem" ]; then
  echo "generate new rootCA"
  read -r pause
  openssl genrsa -out "$HOME/ssl/rootCA.key" 2048
  openssl req -x509 -new -nodes -key "$HOME/ssl/rootCA.key" -sha256 -days 1024 -out "$HOME/ssl/rootCA.pem" -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=prod/CN=Brian LLC rootCA"
  openssl x509 -in rootCA.pem -inform PEM -out rootCA.crt

  # archlinux
  sudo trust anchor --store rootCA.pem

  # gentoo
  echo sudo cp -v rootCA.crt /usr/local/share/ca-certificates
  echo sudo update-ca-certificates
fi

rm -rf v3.ext

cat > v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${server_name}
DNS.2 = localhost
EOF

SUBJECT="/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=None/CN=${server_name}"
openssl req -new -newkey rsa:2048 -sha256 -nodes -keyout ${server_name}.key -subj "$SUBJECT" -out ${server_name}.csr
openssl x509 -req -in ${server_name}.csr -CA "$HOME/ssl/rootCA.pem" -CAkey "$HOME/ssl/rootCA.key" -CAcreateserial -out ${server_name}.crt -days 365 -sha256 -extfile v3.ext

openssl pkcs12 -export -out ${server_name}.p12 -in ${server_name}.crt -inkey ${server_name}.key -name ${server_name} -password "pass:${password}"

# prompts for a password
rm -rf ${server_name}.jks
keytool -importkeystore -srckeystore ${server_name}.p12 -srcstoretype PKCS12 -destkeystore ${server_name}.jks -deststoretype JKS -keypass "${password}" -storepass "${password}"

# cp -v ${server_name}.p12 "${basedir}/raspi-finance-endpoint/src/main/resources/${server_name}-raspi-finance-keystore.p12"
# cp -v ${server_name}.crt "${basedir}/raspi-finance-react/ssl/${server_name}-raspi-finance-cert.pem"
# cp -v ${server_name}.key "${basedir}/raspi-finance-react/ssl/${server_name}-raspi-finance-key.pem"
# cp -v ${server_name}.jks "${basedir}/raspi-finance-ratpack/ssl/${server_name}-raspi-finance.jks"
# cp -v ${server_name}.jks "${basedir}/example-ktor/${server_name}-raspi-finance.jks"
# cp -v ${server_name}.crt ssl/${server_name}-raspi-finance-cert.pem
# cp -v ${server_name}.key ssl/${server_name}-raspi-finance-key.pem

exit 0
