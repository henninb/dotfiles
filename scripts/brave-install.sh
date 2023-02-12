#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install apt-transport-https curl
  curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
  echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt -y update 
  sudo apt install -y brave-browser
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  yay --noconfirm --needed -S brave-bin
  echo sudo ln -sfn /bin/brave /usr/local/bin/brave-browser
elif [ "$OS" = "Solus" ]; then
  sudo eopkg it brave
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo eselect repository enable brave-overlay
  sudo emaint sync -r brave-overlay
  sudo emerge --update --newuse www-client/brave-bin
  sudo ln -sfn /usr/bin/brave-bin /usr/bin/brave-browser
elif [ "$OS" = "Void" ]; then
  sudo xbps-install -y xtools
  cd "$HOME/projects"
  git clone git@github.com:void-linux/void-packages.git
  git clone git@gitlab.com:ElPresidentePoole/brave-bin.git
  cd void-packages || exit
  ./xbps-src binary-bootstrap
  mv -v "$HOME/projects/brave-bin" srcpkgs
  ./xbps-src pkg brave-bin
  xi brave-bin
  echo if fails change the checksum to lower case
  sudo ln -sfn /usr/sbin/brave-browser-stable /usr/sbin/brave-browser
elif [ "$OS" = "fedora" ]; then
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser
else
  echo "$OS is not yet implemented."
fi

echo sudo mkdir -p /var/run/dbus
echo sudo dbus-daemon --system
echo brave-browser --no-sandbox --use-gl=egl
echo sudo snap install brave

echo https://github.com/brave/brave-browser

exit 0

# vim: set ft=sh:
