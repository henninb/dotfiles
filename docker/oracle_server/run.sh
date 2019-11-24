#!/bin/sh

mkdir -p ~/data/oradata
sudo docker image build -t oracle-database-server .
sudo docker stop oracle-database-server
sudo docker rm oracle-database-server -f
#sudo docker run --name=oracle-database-server -h oracle-database-server --restart unless-stopped -d oracle-database-server
sudo docker run --name=oracle-database-server --shm-size=1g -p 1521:1521 -v ~/data/oradata:/u01/app/oracle/oradata -h oracle-database-server -d oracle-database-server
echo sqlplus SYSTEM/monday1@localhost
echo sqlplus SYSTEM/monday1@localhost:1521
echo sqlplus SYSTEM/monday1@192.168.100.217:1521/XE
echo sudo docker exec -it --user root oracle-database-server /bin/sh

exit 0
