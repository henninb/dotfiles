#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service postgresql status
else
  sudo systemctl status postgresql
fi
echo 'netstat -na | grep tcp | grep LIST | grep 5432'
netstat -na | grep tcp | grep LIST | grep 5432
if [ $? -ne 0 ]; then
  echo 5432 port not up, postgesql not running.
fi

echo 'sudo fuser 5432/tcp'
sudo fuser 5432/tcp
if [ $? -ne 0 ]; then
  echo 5432 port not up, postgesql not running.
fi

echo first sudo su - postgres
echo /usr/lib/postgresql/12/bin/pg_ctl  -D /var/lib/postgresql/12/main stop
echo /usr/lib/postgresql/12/bin/pg_ctl  -D /var/lib/postgresql/12/main start

exit 0
