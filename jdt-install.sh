#!/bin/sh

wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.65.0-202011130851.tar.gz

mkdir jdtls
cd jdtls || exit
tar xvf ../jdt-language-server-0.65.0-202011130851.tar.gz

exit 0
