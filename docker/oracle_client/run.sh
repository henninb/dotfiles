#!/bin/sh

RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')
echo $RASPI_IP

if [ ! -f "oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm .
fi

if [ ! -f "oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm" ]; then
  scp pi@$RASPI_IP:/home/pi/downoads/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm .
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
