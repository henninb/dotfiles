#!/bin/sh

echo /etc/lightdm/lightdm
echo dm-tool
echo  dm-tool switch-to-greeter
echo lightdm --test-mode --debug

cat > lightdm.conf <<EOF
[Seat:*]
autologin-guest=false
session-wrapper=/etc/lightdm/Xsession
#autologin-user=henninb
#autologin-user-timeout=0
greeter-session=lightdm-gtk-greeter
#greeter-session=lightdm-webkit2-greeter
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

sudo apt install -y lightdm
sudo apt install -y lightdm-gtk-greeter
sudo apt install -y slick-greeter

# TODO: I am unable to get lightdm functional on one ubuntu system
#sudo apt install -y gdm3
sudo dpkg-reconfigure gdm3

sudo dnf install -y lightdm
sudo dnf install -y lightdm-gtk-greeter

sudo pacman --noconfirm --needed -S lightdm
sudo pacman --noconfirm --needed -S lightdm-gtk-greeter
# sudo pacman --noconfirm --needed -S slick-greeter
#echo /usr/share/xsessions
sudo mv -v bspwm.desktop /usr/share/xsessions/
sudo mv -v xmonad.desktop /usr/share/xsessions/
sudo mv -v lightdm.conf /etc/lightdm/
sudo touch /etc/lightdm/Xsession

# set it back to startx
# sudo systemctl set-default multi-user
# rm /etc/systemd/system/default.target
sudo systemctl set-default graphical
sudo systemctl disable lxdm
sudo systemctl unmask lightdm
sudo systemctl daemon-reload
sudo systemctl enable lightdm

# sudo apt install -y python3-pyqt5.qtwebengine
# sudo apt install -y liblightdm-gobject-1-dev
# sudo apt install -y python3-gi

# cd "$HOME/projects"
# git clone https://github.com/Antergos/web-greeter.git
# cd web-greeter
# sudo make install
ls /usr/share/xgreeters
echo at-spi-bus-launcher
echo  /etc/lightdm/users.conf
echo /usr/libexec/at-spi-bus-launcher
echo gnome-session-properties
echo export NO_AT_BRIDGE=1
echo in /etc/environment


exit 0
