#!/bin/sh

sudo docker build -t apache-server .
sudo docker stop apache-server
sudo docker rm apache-server -f
#sudo sudo docker images
#sudo docker run -dit --name apache-server -h apache-server -p 8080:80 apache-server
sudo docker run --name=apache-server -h apache-server -h apache-server --restart unless-stopped -p 8080:80 -d apache-server
echo running server on port 8080
sudo docker exec -it --user root apache-server /bin/bash

exit 0
