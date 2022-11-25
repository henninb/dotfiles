#!/bin/sh

docker stop postgresql-server
docker rm postgresql-server -f

mkdir -p postgresql-data

stty -echo
printf "New Password for postgres: "
read -r POSTGRESQL_PASSWORD
stty echo
printf "\n"

cat > pg_hba.conf <<EOF
# TYPE  DATABASE      USER   ADDRESS      METHOD
local all             all                 ident
host  all             all    0.0.0.0/0      md5
host  all             all    127.0.0.1/32   md5
host  all             all    ::1/128        md5
EOF

cat > /tmp/install_psql_settings.sql <<EOF
CREATE ROLE vagrant WITH LOGIN PASSWORD '${POSTGRESQL_PASSWORD}';
CREATE ROLE henninb WITH LOGIN PASSWORD '${POSTGRESQL_PASSWORD}';
ALTER USER vagrant CREATEDB;
ALTER USER vagrant SUPERUSER;
ALTER USER henninb CREATEDB;
ALTER USER henninb SUPERUSER;
CREATE DATABASE finance_db;
CREATE DATABASE finance_test_db;
CREATE DATABASE finance_fresh_db;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE postgres TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE finance_test_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE finance_fresh_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE postgres TO henninb;
ALTER USER postgres WITH PASSWORD '${POSTGRESQL_PASSWORD}';
EOF

sudo mkdir -p /opt/postgresql-data
sudo mv -v pg_hba.conf /opt/postgresql-data/pg_hba.conf

# sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /opt/postgresql-data/postgresql.conf
if ! docker-compose up -d; then
  echo "failed docker-compose"
fi

# docker run -dit --name postgresql-server -h postgresql-server postgresql-server
echo docker exec -it postgresql-server /bin/bash
echo psql

exit 0
