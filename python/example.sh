#!/bin/sh

python -m venv ./venv
source ./venv/bin/activate
pip install whatever
python blah blah
deactivate

exit 0
