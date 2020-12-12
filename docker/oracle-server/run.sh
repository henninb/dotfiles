#!/bin/sh

echo docker pull quay.io/maksymbilenko/oracle-12c
echo docker pull store/oracle/database-enterprise:12.2.0.1
mkdir -p ~/oracle-data
docker image build -t oracle-database-server .
docker stop oracle-database-server
docker rm oracle-database-server -f
docker run --name=oracle-database-server --rm --shm-size=1g -p 1521:1521 -v ~/oracle-data:/u01/app/oracle/oradata -h oracle-database-server -d oracle-database-server
echo sqlplus SYSTEM/monday1@localhost
echo sqlplus SYSTEM/monday1@localhost:1521
echo sqlplus SYSTEM/monday1@192.168.100.217:1521/XE
echo sudo docker exec -it --user root oracle-database-server /bin/sh

exit 0
