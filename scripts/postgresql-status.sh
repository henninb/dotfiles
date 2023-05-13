#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service postgresql status
elif [ "$OS" = "Void" ]; then
  doas sv status postgresql
else
  doas systemctl status postgresql
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
echo /usr/lib/postgresql/15/bin/pg_ctl -D /var/lib/postgresql/15/main stop
echo /usr/lib/postgresql/15/bin/pg_ctl -D /var/lib/postgresql/15/main start
echo /usr/lib/postgresql/15/bin/pg_ctl restart -m immediate
echo /usr/lib/postgresql/15/bin/pg_resetwal -f /var/lib/postgresql/15/main/

echo 'psql -h raspi -U henninb finance_db'

exit 0

# vim: set ft=sh:
