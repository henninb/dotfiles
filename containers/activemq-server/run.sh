#!/bin/sh

sudo rm -rf $HOME/activemq-data
mkdir -p $HOME/activemq-data
docker stop activemq-server
docker rm activemq-server -f
docker rmi activemq-server
docker image build -t activemq-server .
#docker images
echo docker exec -it --user root activemq-server /bin/sh
# docker run --name=activemq-server -h activemq-server -h activemq-server --restart unless-stopped -p 8161:8161 -p 61616:61616 -p 61613:61613 -v $HOME/activemq-data:/opt/activemq/data activemq-server
docker run --name=activemq-server -h activemq-server -h activemq-server --restart unless-stopped -p 8161:8161 -p 61616:61616 -p 61613:61613 activemq-server

exit 0
