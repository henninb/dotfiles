#!/bin/sh

echo /etc/lightdm/lightdm
echo dm-tool
echo  dm-tool switch-to-greeter
echo lightdm --test-mode --debug

cat > lightdm.conf <<EOF
[Seat:*]
autologin-guest=false
#autologin-user=henninb
autologin-user-timeout=0
greeter-session=lightdm-gtk-greeter
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

echo /usr/share/xsessions
sudo cp bspwm.desktop /usr/share/xsessions/
sudo cp xmonad.desktop /usr/share/xsessions/

# sudo apt install -y python3-pyqt5.qtwebengine
# sudo apt install -y liblightdm-gobject-1-dev
# sudo apt install -y python3-gi

# cd "$HOME/projects"
# git clone https://github.com/Antergos/web-greeter.git
# cd web-greeter
# sudo make install

sudo apt install -y lightdm
sudo apt install -y lightdm-gtk-greeter
sudo apt install -y slick-greeter

sudo pacman --noconfirm --needed -S lightdm
sudo pacman --noconfirm --needed -S lightdm-gtk-greeter
sudo pacman --noconfirm --needed -S slick-greeter

exit 0
