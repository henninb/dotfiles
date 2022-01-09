#!/bin/sh

docker stop varnish-server
docker rm -f varnish-server

#docker run --name varnish -p 8080:80 varnish
docker-compose up -d

exit 0
