#!/bin/sh

# echo nvm use 16.13.0
echo npm init
echo npm install --save restify bunyan node-config-manager
echo npm install gulp gulp-jshint

echo 'http://localhost:8080/hello/brian'
echo "curl -is http://localhost:8080/hello/mark -H 'accept: text/plain'"
npm start

exit 0
