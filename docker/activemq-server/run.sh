#!/bin/sh

mkdir -p $HOME/activemq_data
sudo docker image build -t activemq .
sudo docker stop activemq
sudo docker rm activemq -f
#sudo sudo docker images
sudo docker run --name=activemq -h activemq --network=bridge -h activemq --restart unless-stopped -p 8161:8161 -p 61616:61616 -p 61613:61613 -v $HOME/activemq_data:/opt/activemq/data -d activemq
sudo docker exec -it --user root activemq /bin/sh

exit 0
