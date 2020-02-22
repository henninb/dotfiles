#!/bin/sh

APP=raspi-finance
# if [ "$OS" = "Linux Mint" ]; then
#   SERVERNAME=silverfox
#   echo $SERVERNAME
# elif [ "$OS" = "CentOS Linux" ]; then
#   SERVERNAME=centos
#   echo $SERVERNAME
# elif [ "$OS" = "Arch Linux" ]; then
#   SERVERNAME=archlinux
#   echo $SERVERNAME
# elif [ "$OS" = "FreeBSD" ]; then
#   SERVERNAME=bsd
#   echo $SERVERNAME
# else
#   echo "$OS not configured."
#   exit 1
# fi
SERVERNAME="$(hostname)"

mkdir -p ssl

echo generate private key
openssl genrsa -out "$HOME/ssl/ca.key.pem" 4096

rm -rf "$HOME/ssl/${SERVERNAME}-${APP}-keystore.jks"
#-storepass
keytool -genkey -keyalg RSA -alias "${SERVERNAME}-${APP}" -keystore "$HOME/ssl/${SERVERNAME}-${APP}-keystore.jks" -storepass monday1 -keypass monday1 -validity 365 -keysize 4096 -dname "CN=$SERVERNAME, OU=$SERVERNAME, O=Brian LLC, L=Denton, ST=Texas, C=US"
keytool -export -alias "${SERVERNAME}-${APP}" -file "$HOME/ssl/${SERVERNAME}-${APP}.der" -keystore "$HOME/ssl/${SERVERNAME}-${APP}-keystore.jks" -keypass monday1 -storepass monday1
#keytool -list -v -keystore keystore.jks
#-dname "CN=$SERVERNAME, OU=$SERVERNAME, O=Brian LLC, L=Denton, ST=Texas, C=US"

echo generate CSR - certificate signing request
openssl req -new -key "$HOME/ssl/ca.key.pem" -out "$HOME/ssl/ca.csr" -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

openssl req -new -key "$HOME/ssl/ca.key.pem" -out "$HOME/ssl/${SERVERNAME}-${APP}.csr.pem" -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

# Generate Self Signed Key
openssl x509 -req -days 365 -in "$HOME/ssl/ca.csr" -signkey "$HOME/ssl/ca.key.pem" -out "$HOME/ssl/ca.crt.pem"
openssl x509 -req -days 365 -in "$HOME/ssl/${SERVERNAME}-${APP}.csr.pem" -signkey "$HOME/ssl/ca.key.pem" -out "$HOME/ssl/${SERVERNAME}-${APP}.crt.pem"

exit 0

#export the .crt:
keytool -export -alias ${SERVERNAME}_${APP} -file mydomain.der -keystore keystore.jks

#convert the cert to PEM:
openssl x509 -inform der -in mydomain.der -out certificate.pem

#export the key:
keytool -importkeystore -srckeystore mycert.jks -destkeystore keystore.p12 -deststoretype PKCS12

#concert PKCS12 key to unencrypted PEM:
openssl pkcs12 -in keystore.p12  -nodes -nocerts -out mydomain.key
