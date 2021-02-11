#!/bin/sh

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
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /opt/postgresql-data/postgresql.conf
cd /tmp
echo sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'

exit 0

sudo docker image build -t postgresql-server .
docker stop postgresql-server
docker rm postgresql-server -f
sudo docker run --name=postgresql-server -h postgresql-server --restart unless-stopped -d postgresql-server
echo docker exec -it --user root postgresql-server /bin/bash
echo docker exec -it postgresql-server /bin/bash

exit 0
