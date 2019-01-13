#!/bin/sh

cd $HOME/projects
git clone git@github.com:oracle/docker-images.git oracle_docker
cd $HOME/projects/oracle_docker/OracleDatabase/SingleInstance/dockerfiles/
if [ ! -f "11.2.0.2/oracle-xe-11.2.0-1.0.x86_64.rpm.zip" ]; then
  scp pi@192.168.100.25:/home/pi/oracle-xe-11.2.0-1.0.x86_64.rpm.zip 11.2.0.2/
fi
./buildDockerImage.sh -v 11.2.0.2 -x

exit 0
