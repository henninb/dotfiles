#!/bin/sh

if [ "$OS" = "Linux Mint" ]; then
  SERVERNAME=mint
  echo $SERVERNAME
elif [ "$OS" = "CentOS Linux" ]; then
  SERVERNAME=centos
  echo $SERVERNAME
elif [ "$OS" = "Arch Linux" ]; then
  SERVERNAME=arch
  echo $SERVERNAME
elif [ "$OS" = "FreeBSD" ]; then
  SERVERNAME=bsd
  echo $SERVERNAME
else
  echo $OS not configured
  exit 1
fi

echo generate private key
openssl genrsa -out $HOME/ca.key.pem 4096

rm -rf keystore.jks
#-storepass
keytool -genkey -keyalg RSA -alias ${SERVERNAME}_apache -keystore keystore.jks -storepass monday1 -keypass monday1 -validity 365 -keysize 4096 -dname "CN=$SERVERNAME, OU=$SERVERNAME, O=Brian LLC, L=Denton, ST=Texas, C=US"
keytool -export -alias ${SERVERNAME}_apache -file mydomain.der -keystore keystore.jks
#keytool -list -v -keystore keystore.jks
#-dname "CN=$SERVERNAME, OU=$SERVERNAME, O=Brian LLC, L=Denton, ST=Texas, C=US"

echo generate CSR - certificate signing request
openssl req -new -key $HOME/ca.key.pem -out $HOME/ca.csr -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

openssl req -new -key $HOME/ca.key.pem -out $HOME/${SERVERNAME}_apache.csr.pem -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

# Generate Self Signed Key
openssl x509 -req -days 365 -in $HOME/ca.csr -signkey $HOME/ca.key.pem -out /$HOME/ca.crt.pem
openssl x509 -req -days 365 -in $HOME/${SERVERNAME}_apache.csr.pem -signkey $HOME/ca.key.pem -out $HOME/${SERVERNAME}_apache.crt.pem

exit 0


#export the .crt:
keytool -export -alias ${SERVERNAME}_apache -file mydomain.der -keystore keystore.jks

#convert the cert to PEM:
openssl x509 -inform der -in mydomain.der -out certificate.pem

#export the key:
keytool -importkeystore -srckeystore mycert.jks -destkeystore keystore.p12 -deststoretype PKCS12

#concert PKCS12 key to unencrypted PEM:
openssl pkcs12 -in keystore.p12  -nodes -nocerts -out mydomain.key
