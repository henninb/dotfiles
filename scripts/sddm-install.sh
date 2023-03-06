#!/bin/sh

cat > "$HOME/tmp/sddm-theme.conf" <<EOF
[Theme]
#Current=maldives
Current=elarun
EOF

cat > "$HOME/tmp/40-wheel-group.rules" <<EOF
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
    	return polkit.Result.YES;
    }
});
EOF

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

cat > "$HOME/tmp/Xsetup" << EOF
setxkbmap us
EOF
chmod 755 "$HOME/tmp/Xsetup"

cat > "$HOME/tmp/sddm.conf" << EOF
[Users]
DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin:/bin
HideShells=
HideUsers="intellij,firefox,tomcat,flatpak,kafka,activemq"
RememberLastSession=true
RememberLastUser=true
ReuseSession=true
InputMethod=

[X11]
DisplayCommand=/etc/sddm/scripts/Xsetup
[Users]
HideUsers=""

[Autologin]
User=henninb
Session=xmonad
EOF

sudo mkdir -p /etc/sddm/
sudo mkdir -p /etc/sddm/scripts/
sudo mkdir -p /usr/share/xsessions/
sudo mv -v "$HOME/tmp/xmonad.desktop" /usr/share/xsessions/
sudo mv -v "$HOME/tmp/cinnamon.desktop" /usr/share/xsessions/
sudo mv -v "$HOME/tmp/Xsetup" /etc/sddm/scripts/

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S sddm
  sudo pacman --noconfirm --needed -S xorg-xsetroot
  sudo systemctl enable sddm.service --now
  sudo systemctl disable lightdm

  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/

  sudo systemctl set-default graphical
  systemctl --user mask gnome-keyring-daemon.service
  systemctl --user mask gnome-keyring-daemon.socket
  # ls -l /usr/share/sddm/themes/

  # systemctl --user stop xdg-desktop-portal{,gtk}
  # systemctl --user stop xdg-desktop-portal
  # systemctl --user disable xdg-desktop-portal{,gtk}
  # systemctl --user disable xdg-desktop-portal
  sudo systemctl enable sddm --now
elif [ "${OS}" = "Void" ]; then
  sudo xbps-install -y sddm
  sudo ln -sfn /etc/sv/sddm /var/service/sddm
  sudo ln -sfn /etc/sv/dbus /var/service/dbus
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf
  sudo sv status sddm
  sudo sv status dbus
elif [ "${OS}" = "Ubuntu" ] || [ "$OS" = "Linux Mint" ]; then
  export DEBIAN_FRONTEND=noninteractive
  sudo apt install -y sddm
  sudo apt install -y sddm-theme-elarun
  # sudo apt remove -y libpam-gnome-keyring
  sudo systemctl set-default graphical
  systemctl --user mask gnome-keyring-daemon.service
  systemctl --user mask gnome-keyring-daemon.socket
  sudo systemctl disable lightdm
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  sudo systemctl enable sddm.service --now
elif [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y sddm
  sudo pkg install -y sysrc
  sudo sysrc sddm_enable="YES"
  sudo mv -v "$HOME/tmp/40-wheel-group.rules" "/usr/local/etc/polkit-1/rules.d/40-wheel-group.rules"
  # sudo sddm --example-config /usr/local/etc/sddm.conf
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/sddm.conf
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  # sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf
  sudo service sddm enable
  echo "https://community.kde.org/FreeBSD/Setup#SDDM"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo zypper install -y sddm
  sudo systemctl set-default graphical
  systemctl --user mask gnome-keyring-daemon.service
  systemctl --user mask gnome-keyring-daemon.socket
  # sudo zypper install -y sddm-themes
  sudo cp -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  # sudo cp -v "$HOME/tmp/sddm-theme.conf" /usr/lib/sddm/sddm.conf.d/sddm-theme.conf
  sudo cp -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  # sudo cp -v "$HOME/tmp/sddm.conf" /usr/lib/sddm/sddm.conf.d/sddm.conf
  sudo rm /usr/lib/sddm/sddm.conf.d/10-theme.conf
  sudo rm /usr/lib/sddm/sddm.conf.d/00-general.conf
  sudo systemctl enable sddm.service --now
  sudo systemctl enable dbus --now
  # sudo systemctl status dbus
  sudo update-alternatives --config default-displaymanager
  sudo chmod +s /usr/bin/Xorg
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y sddm
  sudo dnf install -y sddm-themes
  sudo dnf install -y xsetroot
  sudo dnf install -y gnome-keyring-pam
  sudo systemctl enable sddm --now
  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  echo gkr-pam daemon control file not found
  echo vi /etc/pam.d/gdm-password
  echo auth        optional      pam_gnome_keyring.so only_if=gdm
  sudo dnf remove gnome-keyring-pam
  journalctl -b -u sddm
  echo sddm-greeter --test-mode --theme /usr/share/sddm/themes/elarun
  desktop-file-validate /usr/share/xsessions/xmonad.desktop
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse sddm
  sudo emerge --update --newuse xsetroot
  sudo usermod -a -G video sddm
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf
  sudo mkdir -p /etc/sddm/scripts
  sudo sudo mv -v "$HOME/tmp/Xsetup" /etc/sddm/scripts/Xsetup
  sudo chmod 755 /etc/sddm/scripts/Xsetup
  sudo emerge --update --newuse gui-libs/display-manager-init
  # sudo systemctl enable sddm
  # sudo systemctl start sddm
  sudo systemctl enable sddm.service --now
else
  echo "${OS} is not setup"
  exit 1
fi

# homectl inspect henninb

exit 0

# vim: set ft=sh
