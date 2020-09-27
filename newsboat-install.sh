#!/bin/sh

sudo apt install -y newsboat
sudo apt install -y cmus
sudo apt install -y mpv
sudo apt install -y elinks
sudo apt install -y task-spooler

sudo eopkg install -y sqlite3-devel
sudo eopkg install -y stfl-devel
sudo eopkg install -y json-c-devel
# sudo eopkg install -y asciidoc
cd "$HOME/projects" || exit
git clone git@github.com:xenogenesi/task-spooler.git
cd task-spooler
./configure
autoreconf -f -i
make


cd "$HOME/projects" || exit
git clone git@github.com:newsboat/newsboat.git
cd newsboat || exit
make
sudo make install

exit 0
