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
Name=xmonad
Comment=xmonad dynamic tiling window manager
Exec=xmonad-start
TryExec=xmonad-start
Type=Application
#X-LightDM-DesktopName=xmonad
DesktopNames=xmonad
Keywords=tiling;wm;windowmanager;window;manager;
EOF

cat > "$HOME/tmp/Xsetup" << EOF
setxkbmap us
EOF
chmod 755 "$HOME/tmp/Xsetup"

cat > "$HOME/tmp/sddm.conf" << EOF
[Users]
DefaultPath=/usr/local/sbin:/usr/local/bin:/usr/bin
HideShells=
HideUsers="intellij,firefox,tomcat,flatpak,kafka,activemq"
RememberLastSession=true
RememberLastUser=true
ReuseSession=true

[X11]
DisplayCommand=/etc/sddm/scripts/Xsetup
[Users]
HideUsers=""

[Autologin]
User=henninb
Session=xmonad
EOF

sudo mkdir -p /usr/share/xsessions/
sudo mv -v "$HOME/tmp/xmonad.desktop" /usr/share/xsessions/

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S sddm
  sudo systemctl enable sddm.service --now
  sudo systemctl disable lightdm

  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  # ls -l /usr/share/sddm/themes/

  # systemctl --user stop xdg-desktop-portal{,gtk}
  # systemctl --user stop xdg-desktop-portal
  # systemctl --user disable xdg-desktop-portal{,gtk}
  # systemctl --user disable xdg-desktop-portal
  sudo systemctl enable sddm --now
  # sudo systemctl start sddm
elif [ "${OS}" = "Void" ]; then
  sudo xbps-install -y sddm
  sudo mkdir -p /etc/sddm.conf.d/
  sudo ln -s /etc/sv/sddm /var/service/sddm
  sudo ln -s /etc/sv/dbus /var/service/dbus
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf
  sudo sv status sddm
elif [ "${OS}" = "Ubuntu" ] || [ "$OS" = "Linux Mint" ]; then
  sudo apt install -y sddm
  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo systemctl disable lightdm
  sudo systemctl enable sddm.service --now
elif [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y sddm
  sudo pkg install -y sysrc
  sudo sysrc sddm_enable="YES"
  sudo mv -v "$HOME/tmp/40-wheel-group.rules" "/usr/local/etc/polkit-1/rules.d/40-wheel-group.rules"
  # sudo sddm --example-config /usr/local/etc/sddm.conf
  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/sddm.conf
  # sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf
  sudo service sddm enable
  echo "https://community.kde.org/FreeBSD/Setup#SDDM"
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y sddm
  sudo dnf install -y sddm-themes
  sudo dnf install -y xsetroot
  sudo systemctl enable sddm --now
  # sudo systemctl start sddm
  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  echo gkr-pam daemon control file not found
  echo vi /etc/pam.d/gdm-password
  echo auth        optional      pam_gnome_keyring.so only_if=gdm
  sudo dnf remove   gnome-keyring-pam
  journalctl -b -u sddm
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
