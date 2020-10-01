#!/bin/sh

sudo docker image build -t kafka-server .
docker stop kafka-server
docker rm kafka-server -f
sudo docker run --name=kafka-server -h kafka-server --restart unless-stopped -d kafka-server
echo docker exec -it --user root kafka-server /bin/bash
echo docker exec -it kafka-server /bin/bash

exit 0
