#!/bin/sh

echo npm init

echo 'http://localhost:3000'

echo npm install
echo npm start

echo ssh-add ~/.ssh/id_rsa_gcp

docker context create remote-webserver --docker "host=ssh://brianhenning@34.132.189.202"
export DOCKER_HOST=ssh://brianhenning@34.132.189.202
export DOCKER_HOST=ssh://gcp-api

docker build -t express-app .
docker rm -f express-app
docker run --name=express-app -h express-app --network my-network --restart unless-stopped -p 80:3000 -d express-app

echo connect my-network  postgresql-server
echo connect my-network  express-app

exit 0
