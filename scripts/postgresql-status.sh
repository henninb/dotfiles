#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service postgresql status
elif [ "$OS" = "Void" ]; then
  sudo sv status postgresql
else
  sudo systemctl status postgresql
fi
echo 'netstat -na | grep tcp | grep LIST | grep 5432'
if ! ss -tulpn4 | grep 5432; then
  echo 5432 port not up, postgesql not running.
fi

echo 'sudo fuser 5432/tcp'
if ! sudo fuser 5432/tcp; then
  echo 5432 port not up, postgesql not running.
fi

echo first sudo su - postgres
echo /usr/lib/postgresql/12/bin/pg_ctl -D /var/lib/postgresql/12/main stop
echo /usr/lib/postgresql/12/bin/pg_ctl -D /var/lib/postgresql/12/main start
echo /usr/lib/postgresql/12/bin/pg_ctl restart -m immediate
echo /usr/lib/postgresql/12/bin/pg_resetwal -f /var/lib/postgresql/12/main/

echo 'psql -h raspi -U henninb finance_db'

exit 0

# vim: set ft=sh
