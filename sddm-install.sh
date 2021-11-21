#!/bin/sh

cat > sddm-theme.conf <<EOF
[Theme]
#Current=maldives
Current=elarun
EOF

cat > 40-wheel-group.rules <<EOF
polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
    	return polkit.Result.YES;
    }
});
EOF

cat > xmonad.desktop << EOF
[Desktop Entry]
Name=xmonad
Comment=xmonad dynamic tiling window manager
Exec=xmonad-start
TryExec=xmonad-start
Type=Application
X-LightDM-DesktopName=xmonad
DesktopNames=xmonad
Keywords=tiling;wm;windowmanager;window;manager;
EOF

cat > Xsetup << EOF
setxkbmap us
EOF
chmod 755 Xsetup

cat > sddm.conf << EOF
[X11]
DisplayCommand=/etc/sddm/scripts/Xsetup
EOF

sudo cp -v xmonad.desktop /usr/share/xsessions/

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman -S sddm
  sudo systemctl enable sddm.service -f
  sudo systemctl disable lightdm

  sudo mkdir -p /etc/sddm.conf.d/
  sudo mv -v sddm-theme.conf /etc/sddm.conf.d/
  ls -l /usr/share/sddm/themes/
elif [ "${OS}" = "FreeBSD" ]; then
  sudo pkg install -y sddm
  sudo pkg install -y sysrc
  sysrc sddm_enable="YES"
  sudo mv -v 40-wheel-group.rules /usr/local/etc/polkit-1/rules.d/40-wheel-group.rules
  sudo sddm --example-config /usr/local/etc/sddm.conf
  sudo service sddm start
  echo https://community.kde.org/FreeBSD/Setup#SDDM
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse sddm
  sudo usermod -a -G video sddm
  sudo mv -v sddm.conf /etc/sddm.conf
  sudo mkdir -p /etc/sddm/scripts
  sudo sudo mv -v Xsetup /etc/sddm/scripts/Xsetup
  sudo chmod 755 /etc/sddm/scripts/Xsetup
  sudo emerge --update --newuse gui-libs/display-manager-init
  # echo sudo vi /etc/conf.d/display-manager
  # cat /etc/conf.d/display-manager
  # echo DISPLAYMANAGER="xdm"
  sudo sed -i "s/DISPLAYMANAGER=\"xdm\"/DISPLAYMANAGER=\"sddm\"/g" /etc/conf.d/display-manager
  sudo rc-update add display-manager default
  sudo rc-service display-manager start
else
  echo "${OS} is not setup"
  exit 1
fi

exit 0
