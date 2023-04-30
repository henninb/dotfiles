#!/bin/sh

doas apt -y install imagemagick
doas apt -y install php-imagick
doas apt -y install  libjpeg-dev
sudo emerge --update --newuse media-gfx/imagemagick


cd "$HOME/projects" || exit
wget https://www.imagemagick.org/download/ImageMagick.tar.gz
tar xvf ImageMagick.tar.gz
rm ImageMagick.tar.gz
cd ImageMagick* || exit
./configure
make
doas make install
sudo ldconfig /usr/local/lib

cd "$HOME" || exit

exit 0

# vim: set ft=sh:
