#!/bin/sh

sudo apt install imagemagick
sudo apt install php-imagick
sudo apt-get install  libjpeg-dev


cd projects
wget https://www.imagemagick.org/download/ImageMagick.tar.gz
tar xvf ImageMagick.tar.gz
cd ImageMagick*
./configure
make
sudo make install
sudo ldconfig /usr/local/lib

cd $HOME

exit 0
