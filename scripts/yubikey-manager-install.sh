#!/bin/sh

cat <<  EOF > "$HOME/tmp/70-u2f.rules"
#ACTION!="add|change", GOTO="fido_end"

# YubiKey 4 OTP+FIDO+CCID by Yubico AB
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", TAG+="uaccess", GROUP="plugdev", MODE="0660"
# SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0407", TAG+="uaccess", GROUP="plugdev", MODE="0660"
# ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0113|0114|0115|0116|0120|0402|0403|0406|0407|0410", TAG+="uaccess", GROUP="plugdev", MODE="0660"

#LABEL="fido_end"
EOF

sudo mv -v "$HOME/tmp/70-u2f.rules" /etc/udev/rules.d/70-u2f.rules
if command -v udevadm; then
  sudo udevadm control --reload-rules
fi
systemctl status systemd-udevd

sudo chown root:root /etc/udev/rules.d/70-u2f.rules

# wget 'https://developers.yubico.com/yubikey-manager-qt/Releases/yubikey-manager-qt-1.2.5-linux.AppImage' -O "$HOME/tmp/yubikey-manager-qt-1.2.5-linux.AppImage"
# chmod 755 "$HOME/tmp/yubikey-manager-qt-1.2.5-linux.AppImage"
# cp "$HOME/tmp/yubikey-manager-qt-1.2.5-linux.AppImage" "$HOME/Applications/yubikey-manager-qt.AppImage"

wget 'https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-6.1.0-linux.tar.gz' -O "$HOME/tmp/yubico-authenticator-6.1.0-linux.tar.gz"
sudo tar -zxvf "$HOME/tmp/yubico-authenticator-6.1.0-linux.tar.gz" -C /opt
sudo ln -sfn "/opt/yubico-authenticator-6.1.0-linux" /opt/yubico-authenticator

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo "sudo pacman --noconfirm --needed -S"
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-crypt/yubikey-manager
  sudo emerge --update --newuse yubikey-manager-qt
  # sudo emerge --update --newuse libyubikey
  # sudo emerge --update --newuse app-crypt/libu2f-server
  # sudo emerge --update --newuse app-crypt/libu2f-host
  # sudo emerge --update --newuse sys-auth/pam_u2f
  sudo emerge --update --newuse sys-fs/mtpfs
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo "sudo apt install"
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y yubikey-manager
  sudo xbps-install -y pam_yubico
  sudo xbps-install -y mdevd
  sudo xbps-install -y pcsclite
  sudo xbps-install -y pcsc-ccid
  sudo ln -sfn /etc/sv/pcscd /var/service/pcscd
  # sudo ln -s /etc/sv/pcscd /etc/runit/runsvdir/current/
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

sudo usermod -a -G plugdev "$(whoami)"
sudo gpasswd -a "$(whoami)" usb

# sudo emerge --update --newuse sys-apps/pcsc-lite
# sudo systemctl enable pcscd
# sudo systemctl start pcscd
# sudo systemctl status pcscd
# gpg --card-status

echo sudo /usr/sbin/pcscd -f --info
echo ykman info
which ykman-gui
ykman list --serials

# pamu2fcfg -u "$(whoami)" > ~/.config/Yubico/u2f_keys

# git clone https://github.com/Yubico/yubico-c-client.git
# cd yubico-c-client
# autoreconf --install
#
# git clone https://github.com/Yubico/yubico-pam.git
# cd yubico-pam
# autoreconf --install
# ./configure
#
# make check install

exit 0

# vim: set ft=sh:
