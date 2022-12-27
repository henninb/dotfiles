#!/bin/sh

mkdir -p $HOME/activemq_data
sudo docker image build -t activemq-server .
sudo docker stop activemq-server
sudo docker rm activemq-server -f
#sudo sudo docker images
docker run --name=activemq-server -h activemq-server -h activemq-server --restart unless-stopped -p 8161:8161 -p 61616:61616 -p 61613:61613 -v $HOME/activemq_data:/opt/activemq/data activemq-server
docker exec -it --user root activemq-server /bin/sh

exit 0
