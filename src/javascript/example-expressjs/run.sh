#!/bin/sh

# echo nvm use 16.13.0
echo npm init
echo npm install gulp gulp-jshint
echo npm install express --save

echo 'http://localhost:3001'
echo 'http://localhost:3001/test'
# echo "curl -is http://localhost:8080/hello/mark -H 'accept: text/plain'"
pnpm install
pnpm start

exit 0
