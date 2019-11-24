#!/bin/sh

mkdir -p ~/data/oradata
sudo docker image build -t oraclebox .
sudo docker stop oraclebox
sudo docker rm oraclebox -f
#sudo docker run --name=oraclebox -h oraclebox --restart unless-stopped -d oraclebox
sudo docker run --name=oraclebox --shm-size=1g -p 1521:1521 -v ~/data/oradata:/u01/app/oracle/oradata -h oraclebox -d oraclebox
echo sqlplus SYSTEM/monday1@localhost
echo sqlplus SYSTEM/monday1@localhost:1521
sudo docker exec -it --user root oraclebox /bin/sh

exit 0
