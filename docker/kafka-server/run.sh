#!/bin/sh

sudo docker image build -t kafkabox .
docker stop kafkabox
docker rm kafkabox -f
sudo docker run --name=kafkabox -h kafkabox --restart unless-stopped -d kafkabox
docker exec -it --user root kafkabox /bin/sh

exit 0
