#!/bin/sh

# echo nvm use 16.13.0
echo npm init
npm install --save restify bunyan node-config-manager
npm install gulp gulp-jshint

echo 'http://localhost:8080/hello/brian'
npm start

exit 0
