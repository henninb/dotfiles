#!/bin/sh

cat > "$HOME/tmp/xmonad.desktop" << EOF
[Desktop Entry]
Type=Application
Name=xmonad
Comment=xmonad dynamic tiling window manager
#Path=
Exec=xmonad-start
#DesktopNames=xmonad
Icon=
EOF

cat > "$HOME/tmp/cinnamon.desktop" << EOF
[Desktop Entry]
Type=Application
Name=Cinnamon
Comment=This session logs you into Cinnamon
Exec=cinnamon-session-cinnamon
TryExec=/usr/bin/cinnamon
Icon=
EOF

cat > "$HOME/tmp/lightdm-gtk-greeter.conf" <<EOF
[greeter]
background=/usr/share/backgrounds/custom/greeter.jpg
at-spi-enabled = false
EOF

sudo mkdir -p /usr/share/xsessions/
sudo mv -v "$HOME/tmp/xmonad.desktop" /usr/share/xsessions/
sudo mv -v "$HOME/tmp/cinnamon.desktop" /usr/share/xsessions/

sudo mkdir -p /usr/share/backgrounds/custom/
sudo cp -v "$HOME/.config/lightdm/greeter.jpg" /usr/share/backgrounds/custom/

desktop-file-validate /usr/share/xsessions/xmonad.desktop



if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S lightdm
  sudo pacman --noconfirm --needed -S xorg-xsetroot
  sudo systemctl set-default graphical
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo systemctl disable sddm
  sudo systemctl enable lightdm --now
elif [ "${OS}" = "Void" ]; then
  sudo xbps-install -y lightdm
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo cp -v "$HOME/tmp/lightdm-gtk-greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
  sudo sv status lightdm
  sudo sv status dbus
elif [ "${OS}" = "Ubuntu" ] || [ "$OS" = "Linux Mint" ]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt install -y lightdm
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo cp -v "$HOME/tmp/lightdm-gtk-greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
  sudo systemctl set-default graphical
  sudo systemctl disable sddm
  sudo systemctl enable lightdm --now
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y lightdm
  sudo zypper install -y gnome-keyring-pam
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo cp -v "$HOME/tmp/lightdm-gtk-greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
  sudo systemctl set-default graphical
  sudo usermod -a -G video "$(id -un)"
  sudo systemctl disable sddm
  #sudo systemctl enable lightdm.service --now
  sudo update-alternatives --config default-displaymanager
  update-alternatives --list default-displaymanager
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y lightdm
  sudo dnf install -y xsetroot
  sudo dnf install -y gnome-keyring-pam
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo cp -v "$HOME/tmp/lightdm-gtk-greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
  sudo systemctl set-default graphical
  sudo systemctl disable sddm
  sudo systemctl enable lightdm --now
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse lightdm
  sudo emerge --update --newuse xsetroot
  sudo emerge --update --newuse gui-libs/display-manager-init
  sudo cp -v "$HOME/config/lightdm.conf" /etc/lightdm/lightdm.conf
  sudo cp -v "$HOME/tmp/lightdm-gtk-greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
  sudo usermod -a -G video
  sudo systemctl disable sddm
  sudo systemctl enable lightdm --now
else
  echo "${OS} is not setup"
  exit 1
fi

journalctl -b -u lightdm
grep POSIX_ACL /usr/src/linux/.config
getent passwd "$(whoami)"
echo sudo usermod -g users "$(whoami)"

# homectl inspect henninb

exit 0

# vim: set ft=sh
