echo sudo emerge libcanberra gnome-common gobject-introspection
sudo pacman -S gnome-common
export XDG_DATA_DIRS=/usr/lib64:$XDG_DATA_DIRS
cd projects
git clone https://github.com/linuxmint/slick-greeter.git
cd slick-greeter
./autogen.sh
make
sudo make install

exit 0

maui /  ❯ sudo find . -name "*lightdm-gobject*"
./usr/share/gtk-doc/html/lightdm-gobject-1
./usr/share/gtk-doc/html/lightdm-gobject-1/lightdm-gobject-1-System-Information.html
./usr/share/gtk-doc/html/lightdm-gobject-1/lightdm-gobject-1-Power-Management.html
./usr/share/gtk-doc/html/lightdm-gobject-1/lightdm-gobject-1.devhelp2
./usr/include/lightdm-gobject-1
./usr/lib64/liblightdm-gobject-1.so.0
./usr/lib64/pkgconfig/liblightdm-gobject-1.pc
./usr/lib64/liblightdm-gobject-1.so
./usr/lib64/liblightdm-gobject-1.so.0.0.0

XDG_DATA_DIRS



arcolinux ~  master ❯ sudo find / -name "liblightdm-gobject*"
/usr/lib/liblightdm-gobject-1.so
/usr/lib/pkgconfig/liblightdm-gobject-1.pc
/usr/lib/liblightdm-gobject-1.so.0
/usr/lib/liblightdm-gobject-1.so.0.0.0
/usr/share/vala/vapi/liblightdm-gobject-1.deps
/usr/share/vala/vapi/liblightdm-gobject-1.vapi
