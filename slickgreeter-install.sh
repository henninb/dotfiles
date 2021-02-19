sudo pacman -S gnome-common
cd projects
git clone https://github.com/linuxmint/slick-greeter.git
cd slick-greeter
./autogen.sh
make
sudo make install
