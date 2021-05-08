#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install apt-transport-https curl
  curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
  echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt -y update
  sudo apt install -y brave-browser
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  yay -S brave-bin
  echo sudo ln -sfn /bin/brave /usr/local/bin/brave-browser
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse app-eselect/eselect-repository
  sudo mkdir -p /etc/portage/repos.conf
  sudo eselect repository enable brave-overlay
  sudo emerge --sync
  echo "www-client/brave-bin **" | sudo tee -a /etc/portage/package.accept_keywords
  sudo emerge --update --newuse www-client/brave-bin
  # sudo ln -s /usr/bin/brave-bin /usr/bin/brave
  sudo ln -s /usr/bin/brave-bin /usr/bin/brave-browser
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

exit 0
