#!/bin/sh

if [ ! -f "oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@192.168.100.25:/home/pi/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@192.168.100.25:/home/pi/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@192.168.100.25:/home/pi/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@192.168.100.25:/home/pi/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm .
fi

sudo docker image build -t oracle_client .
docker stop oracle_client
docker rm oracle_client -f
#sudo docker run --name=oracle_client -h oracle_client --restart unless-stopped -d oracle_client
sudo docker run --name=oracle_client -h oracle_client -d oracle_client
echo $?
docker exec -it --user root oracle_client /bin/bash
echo $?

exit 0
