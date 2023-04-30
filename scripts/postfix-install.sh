#!/bin/sh

POSTFIX_PASSWORD="********"
echo "Enter PASSWD: "
read -r POSTFIX_PASSWORD
# if [ -z "$PASSWD" ]; then
#   echo "passwd is empty"
#   exit 1
# fi

# echo $PASSWD

cat > sasl_passwd <<EOF
[smtp.gmail.com]:587 henninb08@gmail.com:${POSTFIX_PASSWORD}
EOF

#sed -i "s/passwd/$PASSWD/g" sasl_passwd
cat sasl_passwd

cat > main.cf <<'EOF'
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
EOF

cat > main_archlinux.cf << 'EOF'
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
EOF

cat > main_centos.cf << 'EOF'
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo mv -v sasl_passwd /etc/postfix/sasl_passwd
  sudo chmod 600 /etc/postfix/sasl_passwd
  sudo mv -v main.cf /etc/postfix/main.cf

  doas apt install -y postfix mailutils
  cd /etc/postfix || exit
  doas chown -R postfix .
  doas chgrp -R postfix .
  doas chmod -R ugo+rwx .
  cd - || exit
  sudo chmod 644 /etc/postfix/*.cf
  sudo postmap /etc/postfix/sasl_passwd
  doas systemctl restart postfix
elif [ "$OS" = "CentOS Linux" ]; then
  sudo mv -v sasl_passwd /etc/postfix/sasl_passwd
  sudo chmod 600 /etc/postfix/sasl_passwd
  sudo mv -v main_centos.cf /etc/postfix/main.cf
  sudo restorecon -v /etc/postfix/main.cf

  doas yum install -y net-tools mailx postfix cyrus-sasl cyrus-sasl-plain
  cd /etc/postfix || exit
  doas chown -R postfix .
  doas chgrp -R postfix .
  doas chmod -R ugo+rwx .
  cd - || exit
  sudo chmod 644 /etc/postfix/*.cf
  sudo postmap /etc/postfix/sasl_passwd
  doas systemctl restart postfix
elif [ "$OS" = "Gentoo" ]; then
  doas emerge --update --newuse postfix
  sudo mv -v sasl_passwd /etc/postfix/sasl_passwd
  sudo chmod 600 /etc/postfix/sasl_passwd
  sudo mv -v main_archlinux.cf /etc/postfix/main.cf
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo mv -v sasl_passwd /etc/postfix/sasl_passwd
  sudo chmod 600 /etc/postfix/sasl_passwd
  sudo mv -v main_archlinux.cf /etc/postfix/main.cf
  doas pacman --noconfirm --needed -S postfix mailutils net-tools
  sudo mkfifo /var/spool/postfix/public/pickup
  cd /etc/postfix || exit
  doas chown -R postfix .
  doas chgrp -R postfix .
  doas chmod -R ugo+rwx .
  cd - || exit
  sudo chmod 644 /etc/postfix/*.cf
  sudo postmap /etc/postfix/sasl_passwd
  doas systemctl restart postfix
else
  echo "$OS not implemented"
  exit 1
fi

echo test | mail -s "Test subject $(uname -n)" henninb@gmail.com

netstat -na | grep 25 | grep LISTEN | grep tcp

exit 0

# vim: set ft=sh:
