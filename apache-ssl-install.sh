#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  SERVERNAME=mint
  echo $SERVERNAME
elif [ "$OS" = "CentOS Linux" ]; then
  SERVERNAME=centos
  echo $SERVERNAME
elif [ "$OS" = "Gentoo" ]; then
  SERVERNAME=gentoo
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

sudo mkdir -p /etc/pki/tls/certs
sudo mkdir -p /etc/pki/tls/private

cat > mint_ssl.conf <<'EOF'
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

cat > bsd_ssl.conf <<'EOF'
Listen 443
SSLProtocol ALL -SSLv2 -SSLv3
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
SSLPassPhraseDialog  builtin
SSLSessionCacheTimeout  300
EOF

cat > arch_ssl.conf <<'EOF'
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

cat > main.html <<'EOF'
<html>
  <head><title>apache server</title></head>
  <body>
  my data
  </body>
</html>
EOF

echo generate private key
openssl genrsa -out $HOME/ca.key.pem 4096

echo generate CSR - certificate signing request
openssl req -new -key $HOME/ca.key.pem -out $HOME/ca.csr -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

openssl req -new -key $HOME/ca.key.pem -out $HOME/${SERVERNAME}_apache.csr.pem -subj "/C=US/ST=Texas/L=Denton/O=Brian LLC/OU=$SERVERNAME/CN=$SERVERNAME"

# Generate Self Signed Key
openssl x509 -req -days 3650 -in $HOME/ca.csr -signkey $HOME/ca.key.pem -out $HOME/ca.crt.pem
openssl x509 -req -days 365 -in $HOME/${SERVERNAME}_apache.csr.pem -signkey $HOME/ca.key.pem -out $HOME/${SERVERNAME}_apache.crt.pem

sudo cp -v $HOME/ca.crt.pem /etc/pki/tls/certs
sudo cp -v $HOME/${SERVERNAME}_apache.crt.pem /etc/pki/tls/certs
sudo cp -v $HOME/ca.key.pem /etc/pki/tls/private

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y apache2
  sudo a2enmod ssl
  sudo a2ensite $SERVERNAME
  sudo mv -v mint_ssl.conf /etc/apache2/sites-available/mint.conf
  sudo mv -v main.html /var/www/index.html

  #openssl x509 -in $HOME/${SERVERNAME}_apache.crt.pem -inform PEM -out $HOME/${SERVERNAME}_apache.crt
  sudo chmod 644 $HOME/${SERVERNAME}_apache.crt.pem
  sudo chmod 644 $HOME/ca.crt.pem
  sudo mkdir -p /usr/share/ca-certificates/extra
  sudo cp -v $HOME/${SERVERNAME}_apache.crt.pem /usr/share/ca-certificates/${SERVERNAME}_apache.crt
  sudo update-ca-certificates
  echo sudo update-ca-certificates --fresh
  echo sudo dpkg-reconfigure ca-certificates

  sudo systemctl reload apache2
  sudo systemctl start apache2
  sudo systemctl restart apache2
  sudo systemctl enable apache2
  grep "127.0.0.1 mint" /etc/hosts
  if [ $? -ne 0 ]; then
    echo "127.0.0.1 mint" | sudo tee -a /etc/hosts
  fi
  curl https://mint > index.html
  curl --cacert /usr/share/ca-certificates/${SERVERNAME}_apache.crt https://mint
  ls -l /etc/ssl/certs/ca-certificates.crt
  echo keytool -printcert -v -file /etc/ssl/certs/ca-certificates.crt
  echo curl-config --ca
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y httpd mod_ssl openssl curl openssl-perl
  sudo yum install -y net-tools psmisc wget

  sudo systemctl start firewalld
  sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
  sudo firewall-cmd --permanent --add-port=443/tcp --permanent
  sudo firewall-cmd --reload
  sudo firewall-cmd --list-ports

  sudo sed -i "s/SSLCertificateFile \/etc\/pki\/tls\/certs\/localhost.crt/SSLCertificateFile \/etc\/pki\/tls\/certs\/centos_apache.crt.pem/g" /etc/httpd/conf.d/ssl.conf
  sudo sed -i "s/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/localhost.key/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/ca.key.pem/g" /etc/httpd/conf.d/ssl.conf
  sudo sed -i "s/SSLCertificateFile \/etc\/pki\/tls\/certs\/ca.crt/SSLCertificateFile \/etc\/pki\/tls\/certs\/centos_apache.crt.pem/g" /etc/httpd/conf.d/ssl.conf
  sudo sed -i "s/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/ca.key\$/SSLCertificateKeyFile \/etc\/pki\/tls\/private\/ca.key.pem/g" /etc/httpd/conf.d/ssl.conf

  #not sure if this is required
  sudo update-ca-trust force-enable
  sudo cp $HOME/centos_apache.crt.pem /etc/pki/ca-trust/source/anchors/
  sudo update-ca-trust extract

  sudo systemctl start httpd
  sudo systemctl restart httpd
  sudo systemctl enable httpd

  grep "127.0.0.1 centos" /etc/hosts
  if [ $? -ne 0 ]; then
    echo "127.0.0.1 centos" | sudo tee -a /etc/hosts
  fi
  curl https://centos > index.html
  netstat -na | grep LIST| grep tcp | grep 80
  netstat -na | grep LIST| grep tcp | grep 443

  sudo fuser 443/tcp
  sudo fuser 80/tcp
  #sudo cp -v index.html /var/www/html
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge apache
  sudo emerge net-tools
elif [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S net-tools apache curl
  sudo mkdir -p /var/www
  sudo mv -v main.html /var/www/index.html
  grep "127.0.0.1 arch" /etc/hosts
  if [ $? -ne 0 ]; then
    echo "127.0.0.1 arch" | sudo tee -a /etc/hosts
  fi

  sudo cp -v $HOME/arch_ssl.conf /etc/httpd/conf/ssl.conf

  grep "Listen 443" /etc/httpd/conf/httpd.conf
  if [ $? -ne 0 ]; then
    echo "Listen 443" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "LoadModule ssl_module modules/mod_ssl.so" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "LoadModule socache_shmcb_module modules/mod_socache_shmcb.so" | sudo tee -a /etc/httpd/conf/httpd.conf
    echo "Include conf/extra/httpd-vhosts.conf" | sudo tee -a /etc/httpd/conf/httpd.conf
  fi

  grep "Include /etc/httpd/conf/ssl.conf" /etc/httpd/conf/httpd.conf
  if [ $? -ne 0 ]; then
    echo "Include /etc/httpd/conf/ssl.conf" | sudo tee -a /etc/httpd/conf/httpd.conf
  fi

  sudo trust anchor /etc/pki/tls/certs/arch_apache.crt.pem
  # trust anchor --remove /etc/pki/tls/certs/arch_apache.crt.pem

  sudo systemctl start httpd
  sudo systemctl restart httpd
  sudo systemctl enable httpd

  sleep 4
  netstat -na | grep LIST| grep tcp | grep 80
  netstat -na | grep LIST| grep tcp | grep 443

  sudo fuser 443/tcp
  sudo fuser 80/tcp
  echo curl https://arch > index.html
  curl https://arch > index.html
  curl --cacert /etc/pki/tls/certs/${SERVERNAME}_apache.crt.pem https://arch > index2.html
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y apache24
  sudo sysrc  apache24_enable="YES"
  sudo service apache24 start
  netstat -na | grep tcp | grep LIST | grep 80
  sudo mkdir /usr/local/etc/apache24/sites-available
  sudo mkdir /usr/local/etc/apache24/sites-enabled
  echo "IncludeOptional etc/apache24/sites-enabled/*.conf" | sudo tee -a /usr/local/etc/apache24/httpd.conf
  echo "LoadModule ssl_module libexec/apache24/mod_ssl.so" | sudo tee -a /usr/local/etc/apache24/httpd.conf
  echo /usr/local/www/apache24/data/
  echo https://www.tecmint.com/install-lets-encrypt-ssl-certificate-for-apache-on-freebsd/
else
  echo $OS needs to be setup.
  exit 1
fi

exit 0

curl --cacert $HOME/centos_apache.crt.pem https://centos7
openssl s_client -connect centos7:443 -CAfile $HOME/centos_apache.crt.pem


#ls -l /etc/pki/tls/openssl.cnf

exit 0
