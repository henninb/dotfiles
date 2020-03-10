#!/bin/sh

sudo apt -y install imagemagick
sudo apt -y install php-imagick
sudo apt -y install  libjpeg-dev


cd "$HOME/projects"
wget https://www.imagemagick.org/download/ImageMagick.tar.gz
tar xvf ImageMagick.tar.gz
rm ImageMagick.tar.gz
cd ImageMagick*
./configure
make
sudo make install
sudo ldconfig /usr/local/lib

cd "$HOME"

exit 0
