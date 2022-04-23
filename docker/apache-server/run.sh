#!/bin/sh

docker build -t apache-server .
docker stop apache-server
docker rm apache-server -f
#sudo sudo docker images
#sudo docker run -dit --name apache-server -h apache-server -p 8080:80 apache-server
docker run --name=apache-server -h apache-server -h apache-server --restart unless-stopped -p 8080:80 -d apache-server
echo running server on port 8080
echo docker exec -it --user root apache-server /bin/bash
echo docker logs apache-server

exit 0
