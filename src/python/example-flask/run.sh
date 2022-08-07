#!/bin/sh

pip install -r requirements.txt

export FLASK_ENV=development
export FLASK_APP=example.py
flask run

exit 0
