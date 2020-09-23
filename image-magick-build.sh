#!/bin/sh

sudo apt -y install imagemagick
sudo apt -y install php-imagick
sudo apt -y install  libjpeg-dev


cd "$HOME/projects" || exit
wget https://www.imagemagick.org/download/ImageMagick.tar.gz
tar xvf ImageMagick.tar.gz
rm ImageMagick.tar.gz
cd ImageMagick* || exit
./configure
make
sudo make install
sudo ldconfig /usr/local/lib

cd "$HOME" || exit

exit 0
