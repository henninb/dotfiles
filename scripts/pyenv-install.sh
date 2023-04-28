#!/bin/sh

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init --path)"' >> ~/.profile

sudo apt install -y make build-essential libssl-dev zlib1g-dev \
 libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev\
 libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

pyenv global 3.9.4
pyenv version

exit 0

# vim: set ft=sh:
