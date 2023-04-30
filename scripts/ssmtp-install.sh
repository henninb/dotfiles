#!/bin/sh

SSMTP_PASSWORD="********"
echo "Enter PASSWD: "
read -r SSMTP_PASSWORD
# if [ -z "$PASSWD" ]; then
#   echo "passwd is empty"
#   exit 1
# fi
# echo "$PASSWD"

cat > ssmtp.conf <<EOF
mailhub=smtp.gmail.com:587
AuthUser=henninb08@gmail.com
AuthPass=${SSMTP_PASSWORD}
UseSTARTTLS=YES
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  echo "sudo emerge --update --newuse"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  doas apt install -y postfix
  doas apt install -y ssmtp mailutils net-tools
  sudo mv -v ssmtp.conf /etc/ssmtp/ssmtp.conf
  sudo chown root:mail /etc/ssmtp/ssmtp.conf
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  echo "sudo pkg install -y"
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo test | mail -s "Test subject $(uname -n)" henninb@gmail.com

netstat -na | grep 25 | grep LISTEN | grep tcp

exit 0

# vim: set ft=sh:
