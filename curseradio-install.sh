#!/bin/sh

cd projects
git clone https://github.com/chronitis/curseradio.git
cd curseradio
sudo python setup.py install

exit 0
