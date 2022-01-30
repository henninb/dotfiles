#!/bin/sh

curl -O https://bootstrap.pypa.io/get-pip.py
pip install Flask
#py -m pip install Flask
export FLASK_ENV=development
export FLASK_APP=example.py
# python example.py
flask run

exit 0
