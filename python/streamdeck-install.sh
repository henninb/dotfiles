#!/bin/sh

wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz
tar xzf Python-3.9.16.tgz 
rm Python-3.9.16.tgz
cd Python-3.9.16 
sudo ./configure --enable-optimizations 
sudo make altinstall
python3.9 -V
echo pipenv install --python 3.9.16
pip install virtualenv
virtualenv -p $(which python3.9) streamdeck-env
#python3 -m venv streamdeck

echo source streamdeck-env/bin/activate
echo deactivate

pip3 install streamdeck-ui
mv "$HOME/python/streamdeck-env/bin/streamdeck" ~/.local/bin

exit 0
