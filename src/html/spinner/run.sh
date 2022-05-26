#!/bin/sh

if [ ! -x "$(command -v node)" ]; then
  echo "Please install node"
  exit 1
fi

npm install
npm start

exit 0
