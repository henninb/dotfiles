#!/bin/sh

wget https://openresty.org/download/openresty-1.21.4.1.tar.gz
tar -xvf openresty-1.21.4.1.tar.gz
cd openresty-1.21.4.1

./configure --prefix=/usr/local/openresty \
            --with-luajit \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-pcre-jit \
            --with-openssl
make

sudo pacman -S luarocks
sudo systemctl enable openresty.service
