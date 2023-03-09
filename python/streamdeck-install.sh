#!/bin/sh

if command -v emerge; then
  sudo emerge --update --newuse dev-libs/hidapi
elif command -v zypper; then
  sudo zypper install -y libhidapi-devel
  sudo zypper install -y python-devel
elif command -v apt; then
  sudo apt install -y python-dev-is-python3
  sudo apt install -y libhidapi-libusb0
  sudo apt install -y libxcb-xinerama0
  sudo apt install -y libhidapi-dev
elif command -v dnf; then
  sudo dnf install -y libusb1-devel
  sudo dnf install -y libgudev-devel
  sudo dnf install -y hidapi-devel
  sudo dnf install -y libudev-devel
  sudo dnf install -y freetype-devel
  sudo dnf install -y hidapi-devel
  sudo dnf install -y libhid-devel
  sudo dnf install -y libjpeg-devel
  sudo dnf install -y libpng-devel
  sudo dnf install -y libxc-devel
  sudo dnf install -y systemd-devel
  sudo dnf install -y zlib-devel
elif command -v xbps-install; then
  # sudo xbps-install -y elogind
  sudo xbps-install -y hidapi-devel
  # sudo ln -sfn /etc/sv/elogind /var/service/elogind
  sudo xbps-install -y libgusb-devel
  sudo xbps-install -y python3-devel
fi

pip install virtualenv
pip install pipenv

if ! command -v python3.9; then
  wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz
  tar xzf Python-3.9.16.tgz 
  rm Python-3.9.16.tgz
  cd Python-3.9.16 
  sudo ./configure --enable-optimizations 
  sudo make altinstall
  python3.9 -V
echo pipenv install --python 3.9.16
fi
mkdir -p streamdeck-env
virtualenv -p $(which python3.9) streamdeck-env
#python3 -m venv streamdeck

echo source streamdeck-env/bin/activate
echo deactivate

pip3 install streamdeck-ui
mv "$HOME/python/streamdeck-env/bin/streamdeck" ~/.local/bin

exit 0
