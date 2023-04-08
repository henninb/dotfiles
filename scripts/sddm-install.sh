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
#Type=Application
Type=XSession
Name=xmonad
Comment=xmonad dynamic tiling window manager
#Path=
Exec=xmonad-start
#DesktopNames=xmonad
#Icon=
Icon=/usr/share/pixmaps/xmonad.png
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
setxkbmap -option "caps:escape"
date >> "$HOME/tmp/xsetup.log"
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

[General]
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
sudo mkdir -p /usr/share/pixmaps/
sudo mv -v "$HOME/tmp/xmonad.desktop" /usr/share/xsessions/
sudo mv -v "$HOME/tmp/cinnamon.desktop" /usr/share/xsessions/
sudo mv -v "$HOME/tmp/Xsetup" /etc/sddm/scripts/
sudo cp -v "$HOME/.local/img/xmonad.png" /usr/share/pixmaps/xmonad.png

sudo rm -rf /var/lib/sddm/.cache/

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
  sudo zypper install -y gnome-keyring-pam
  sudo systemctl set-default graphical
  sudo usermod -a -G video "$(id -un)"
  sudo usermod -a -G systemd-journal "$(id -un)"
  sudo chown sddm:sddm /var/lib/sddm/state.conf
  value=$(grep "^DISPLAYMANAGER_AUTOLOGIN=" /etc/sysconfig/displaymanager | cut -d= -f2)
  if [ -z "$value" ]; then
    sudo sed -i 's/^DISPLAYMANAGER_AUTOLOGIN=.*/DISPLAYMANAGER_AUTOLOGIN="henninb"/' /etc/sysconfig/displaymanager
  fi
  echo DISPLAYMANAGER_AUTOLOGIN="henninb"
  echo /etc/sysconfig/displaymanager
  systemctl --user mask gnome-keyring-daemon.service
  systemctl --user mask gnome-keyring-daemon.socket
  sudo cp -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo cp -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  sudo systemctl set-default graphical
  echo /usr/share/sddm/scripts/Xsetup
  # sudo systemctl enable dbus --now
  # sudo systemctl status dbus
  sudo update-alternatives --config default-displaymanager
  # grep -Hriv "^$" /etc/pam.d/sddm*
  update-alternatives --list default-displaymanager
  sudo usermod -a -G systemd-journal "$(id -un)"
  sudo systemctl enable sddm.service --now
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y sddm
  sudo dnf install -y sddm-themes
  sudo dnf install -y xsetroot
  sudo dnf install -y gnome-keyring-pam
  sudo dnf install -y gnome-keyring-pam
  sudo systemctl set-default graphical
  sudo dnf remove -y gdm
  sudo systemctl disable gdm
  sudo systemctl disable lightdm
  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm-theme.conf" /etc/sddm.conf.d/
  sudo mv -v "$HOME/tmp/sddm.conf" /etc/sddm.conf.d/
  echo gkr-pam daemon control file not found
  echo vi /etc/pam.d/gdm-password
  echo auth        optional      pam_gnome_keyring.so only_if=sddm
  #sudo dnf remove gnome-keyring-pam
  echo journalctl -b -u sddm
  echo sddm-greeter --test-mode --theme /usr/share/sddm/themes/elarun
  desktop-file-validate /usr/share/xsessions/xmonad.desktop
  sudo systemctl enable sddm --now
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse sddm
  sudo emerge --update --newuse xsetroot
  sudo systemctl set-default graphical
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

grep POSIX_ACL /usr/src/linux/.config
ls /usr/share/sddm/scripts/Xsession
getent passwd "$(whoami)"
echo sudo usermod -g users "$(whoami)"

sudo cat /var/lib/sddm/.local/share/sddm/xorg-session.log

# homectl inspect henninb

exit 0

# vim: set ft=sh
