#!/bin/sh

# RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')
# echo $RASPI_IP

cd "$HOME/projects" || exit
git clone git@github.com:oracle/docker-images.git oracle-server-docker
cd oracle-server-docker || exit
git pull
cd "$HOME/projects/oracle-server-docker/OracleDatabase/SingleInstance/dockerfiles/"
if [ ! -f "11.2.0.2/oracle-xe-11.2.0-1.0.x86_64.rpm.zip" ]; then
  scp pi@$RASPI_IP:/home/pi/downloads/oracle-xe-11.2.0-1.0.x86_64.rpm.zip 11.2.0.2/
fi
./buildDockerImage.sh -v 11.2.0.2 -x

exit 0
