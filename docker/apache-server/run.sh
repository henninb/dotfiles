#!/bin/sh

sudo docker build -t apache2box .
sudo docker stop apache2box
sudo docker rm apache2box -f
#sudo sudo docker images
sudo docker run -dit --name apache2box -h apache2box -p 8080:80 apache2box
sudo docker exec -it --user root apache2box /bin/bash

exit 0
