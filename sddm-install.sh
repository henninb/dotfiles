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
else
  echo "${OS} is not setup"
  exit 1
fi

exit 0
