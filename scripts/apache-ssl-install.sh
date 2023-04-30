#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  SERVERNAME=mint
  echo $SERVERNAME
elif [ "$OS" = "Gentoo" ]; then
  SERVERNAME=gentoo
  echo $SERVERNAME
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  SERVERNAME=arch
  echo $SERVERNAME
elif [ "$OS" = "FreeBSD" ]; then
  SERVERNAME=bsd
  echo $SERVERNAME
else
  echo "$OS not configured"
  exit 1
fi

sudo mkdir -p /etc/pki/tls/certs
sudo mkdir -p /etc/pki/tls/private

cat > mint_ssl.conf <<EOF
<IfModule mod_ssl.c>
  <VirtualHost *:443>
    DocumentRoot /var/www/
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/mint_apache.crt.pem
    SSLCertificateKeyFile /etc/pki/tls/private/ca.key.pem
    #SSLCertificateChainFile /path/to/DigiCertCA.crt
  </VirtualHost>
</IfModule>
EOF

cat > bsd_ssl.conf <<EOF
Listen 443
SSLProtocol ALL -SSLv2 -SSLv3
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLPassPhraseDialog  builtin
SSLSessionCacheTimeout  300
EOF

cat > arch_ssl.conf <<EOF
<IfModule mod_ssl.c>
  <VirtualHost *:443>
    DocumentRoot /var/www/
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/arch_apache.crt.pem
    SSLCertificateKeyFile /etc/pki/tls/private/ca.key.pem
    #SSLCertificateChainFile /path/to/DigiCertCA.crt
  </VirtualHost>
</IfModule>
EOF

cat > main.html <<EOF
<html>
  <head><title>apache server</title></head>
  <body>
  my data
  </body>
</html>
EOF

echo generate private key
openssl genrsa -out "$HOME/ca.key.pem" 4096

echo generate CSR - certificate signing request
openssl req -new -key "$HOME/ca.key.pem" -out "$HOME/ca.csr" -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

openssl req -new -key "$HOME/ca.key.pem" -out "$HOME/${SERVERNAME}_apache.csr.pem" -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

# Generate Self Signed Key
openssl x509 -req -days 3650 -in "$HOME/ca.csr" -signkey "$HOME/ca.key.pem" -out "$HOME/ca.crt.pem"
openssl x509 -req -days 365 -in "$HOME/${SERVERNAME}_apache.csr.pem" -signkey "$HOME/ca.key.pem" -out "$HOME/${SERVERNAME}_apache.crt.pem"

sudo cp -v "$HOME/ca.crt.pem" /etc/pki/tls/certs
sudo cp -v "$HOME/${SERVERNAME}_apache.crt.pem" /etc/pki/tls/certs
sudo cp -v "$HOME/ca.key.pem" /etc/pki/tls/private

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y apache2
  doas a2enmod ssl
  doas a2ensite $SERVERNAME
  sudo mv -v mint_ssl.conf /etc/apache2/sites-available/mint.conf
  sudo mv -v main.html /var/www/index.html

  #openssl x509 -in $HOME/${SERVERNAME}_apache.crt.pem -inform PEM -out $HOME/${SERVERNAME}_apache.crt
  sudo chmod 644 "$HOME/${SERVERNAME}_apache.crt.pem"
  sudo chmod 644 "$HOME/ca.crt.pem"
  sudo mkdir -p /usr/share/ca-certificates/extra
  sudo cp -v "$HOME/${SERVERNAME}_apache.crt.pem" /usr/share/ca-certificates/${SERVERNAME}_apache.crt
  doas update-ca-certificates
  echo sudo update-ca-certificates --fresh
  echo sudo dpkg-reconfigure ca-certificates

  doas systemctl reload apache2
  doas systemctl start apache2
  doas systemctl restart apache2
  doas systemctl enable apache2
  if ! grep -q "127.0.0.1 mint" /etc/hosts; then
    echo "127.0.0.1 mint" | sudo tee -a /etc/hosts >/dev/null
  fi
  curl https://mint > index.html
  curl --cacert /usr/share/ca-certificates/${SERVERNAME}_apache.crt https://mint
  ls -l /etc/ssl/certs/ca-certificates.crt
  echo keytool -printcert -v -file /etc/ssl/certs/ca-certificates.crt
  echo curl-config --ca
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse apache
  doas emerge --update --newuse net-tools
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  doas pacman --noconfirm --needed -S net-tools apache curl
  sudo mkdir -p /var/www
  sudo mv -v main.html /var/www/index.html
  if ! grep -q "127.0.0.1 arch" /etc/hosts; then
    echo "127.0.0.1 arch" | sudo tee -a /etc/hosts >/dev/null
  fi
  sudo cp -v "$HOME/arch_ssl.conf" /etc/httpd/conf/ssl.conf

  if ! grep -q "Listen 443" /etc/httpd/conf/httpd.conf; then
    echo "Listen 443" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "LoadModule ssl_module modules/mod_ssl.so" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "LoadModule socache_shmcb_module modules/mod_socache_shmcb.so" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "Include conf/extra/httpd-vhosts.conf" | sudo tee -a /etc/httpd/conf/httpd.conf
  fi

  if ! grep -q "Include /etc/httpd/conf/ssl.conf" /etc/httpd/conf/httpd.conf; then
    echo "Include /etc/httpd/conf/ssl.conf" | sudo tee -a /etc/httpd/conf/httpd.conf
  fi

  sudo trust anchor /etc/pki/tls/certs/arch_apache.crt.pem
  # trust anchor --remove /etc/pki/tls/certs/arch_apache.crt.pem

  doas systemctl start httpd
  doas systemctl restart httpd
  doas systemctl enable httpd

  sleep 4
  netstat -na | grep LIST| grep tcp | grep 80
  netstat -na | grep LIST| grep tcp | grep 443

  sudo fuser 443/tcp
  sudo fuser 80/tcp
  echo curl https://arch > index.html
  curl https://arch > index.html
  curl --cacert /etc/pki/tls/certs/${SERVERNAME}_apache.crt.pem https://arch > index2.html
elif [ "$OS" = "FreeBSD" ]; then
  doas pkg install -y apache24
  doas sysrc  apache24_enable="YES"
  doas service apache24 start
  netstat -na | grep tcp | grep LIST | grep 80
  sudo mkdir /usr/local/etc/apache24/sites-available
  sudo mkdir /usr/local/etc/apache24/sites-enabled
  echo "IncludeOptional etc/apache24/sites-enabled/*.conf" | sudo tee -a /usr/local/etc/apache24/httpd.conf
  echo "LoadModule ssl_module libexec/apache24/mod_ssl.so" | sudo tee -a /usr/local/etc/apache24/httpd.conf
  echo /usr/local/www/apache24/data/
  echo https://www.tecmint.com/install-lets-encrypt-ssl-certificate-for-apache-on-freebsd/
else
  echo "$OS needs to be setup."
  exit 1
fi

exit 0

# curl --cacert $HOME/centos_apache.crt.pem https://centos7
# openssl s_client -connect $SERVERNAME:443 -CAfile $HOME/centos_apache.crt.pem

# vim: set ft=sh:
