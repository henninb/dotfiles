#!/bin/sh

echo dm-tool
echo  dm-tool switch-to-greeter
echo lightdm --test-mode --debug

cat > lightdm.conf <<EOF
#[Seat:*]
[SeatDefaults]
autologin-guest=false
session-wrapper=/etc/lightdm/Xsession
#autologin-user=henninb
#autologin-user-timeout=0
#pam-service=lightdm-autologin
greeter-session=lightdm-gtk-greeter
#greeter-session=lightdm-webkit2-greeter
#greeter-session=slick-greeter
greeter-hide-users=false
EOF

cat > lightdm-gtk-greeter.conf <<EOF
[greeter]
background=/usr/share/backgrounds/custom/lightdm.jpg
at-spi-enabled = false
EOF

cat > bspwm.desktop << EOF
[Desktop Entry]
Name=bspwm
Comment=bspwm tiling window manager
Exec=bspwm
TryExec=bspwm
Type=Application
X-LightDM-DesktopName=bspwm
DesktopNames=bspwm
Keywords=tiling;wm;windowmanager;window;manager;
EOF

cat > xmonad.desktop << EOF
[Desktop Entry]
Name=xmonad
Comment=xmonad dynamic tiling window manager
Exec=xmonad
TryExec=xmonad
Type=Application
X-LightDM-DesktopName=xmonad
DesktopNames=xmonad
Keywords=tiling;wm;windowmanager;window;manager;
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  # TODO: I am unable to get lightdm functional on one ubuntu system at this time
  sudo apt install -y lightdm
  sudo apt install -y lightdm-gtk-greeter
  sudo apt install -y slick-greeter
  sudo apt install -y lightdm-settings
  sudo apt install -y gdm3
  sudo dpkg-reconfigure lightdm
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  echo switched home directory for lightdm to: /var/lib/lightdm-data/lightdm
  sudo pacman --noconfirm --needed -S lightdm
  sudo pacman --noconfirm --needed -S lightdm-gtk-greeter
  # sudo pacman --noconfirm --needed -S slick-greeter
elif [ "$OS" = "Gentoo" ]; then
  sudo USE="introspection elogind" emerge --update --newuse sys-apps/accountsservice
  sudo emerge --update --newuse lightdm
  sudo emerge --update --newuse lightdm-gtk-greeter
  sudo touch /etc/lightdm/slick-greeter.conf

  sudo USE="introspection ipv6 tcpd elogind" emerge --update --newuse gdm

  echo /etc/conf.d/xdm
  echo DISPLAYMANAGER = "lightdm"
  #sudo rc-update add lightdm default
  sudo rc-update add dbus default
  sudo rc-update add xdm default
  sudo rc-service dbus start
  sudo rc-service xdm start
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y lightdm
  sudo dnf install -y lightdm-gtk-greeter
fi

#echo /usr/share/xsessions
sudo mv -v bspwm.desktop /usr/share/xsessions/
sudo mv -v xmonad.desktop /usr/share/xsessions/
sudo mkdir -p /usr/share/backgrounds/custom
sudo mv -v lightdm.conf /etc/lightdm/
sudo touch /etc/lightdm/Xsession
# to disable brian
sudo touch /var/lib/AccountsService/users/brian

# set startup back to startx/.initrx
# sudo systemctl set-default multi-user
# rm /etc/systemd/system/default.target
# set startup to use a dm
sudo systemctl set-default graphical
sudo systemctl disable lxdm
sudo systemctl unmask lightdm
sudo systemctl daemon-reload
sudo systemctl enable lightdm

echo /etc/pam.d/lightdm
ls /etc/lightdm/slick-greeter.conf
ls /usr/share/xgreeters
lightdm --show-config

echo sudo touch /etc/securetty
# echo at-spi-bus-launcher
# echo  /etc/lightdm/users.conf
# echo /usr/libexec/at-spi-bus-launcher
# echo gnome-session-properties
# echo export NO_AT_BRIDGE=1
# echo in /etc/environment
sudo journalctl -b -u lightdm.service

echo /etc/pam.d/lightdm
echo remove pam_kwallet.so is in libpam-kwallet4 and pam_kwallet5.so by libpam-kwallet5

exit 0

accountsservice
DEBUG: Registering seat with bus path /org/freedesktop/DisplayManager/Seat0
DEBUG: Loading users from org.freedesktop.Accounts
/org/freedesktop/Accounts/User1001 added
 DEBUG: User /org/freedesktop/Accounts/User1002 added
 DEBUG: User /org/freedesktop/Accounts/User1000 added
 DEBUG: User /org/freedesktop/Accounts/User1007 added
 DEBUG: User /org/freedesktop/Accounts/User64055 added
 DEBUG: User /org/freedesktop/Accounts/User1004 added
 DEBUG: User /org/freedesktop/Accounts/User1003 added
 DEBUG: User /org/freedesktop/Accounts/User1005 added
 DEBUG: User /org/freedesktop/Accounts/User1006 added

 sudo dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u "$USER") org.freedesktop.Accounts.User.SetXSession string:xmonad
