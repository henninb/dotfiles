#!/bin/sh

date=$(date '+%Y-%m-%d')

cat > /tmp/sql-setup <<EOF
CREATE ROLE vagrant WITH LOGIN PASSWORD 'monday1';
CREATE ROLE henninb WITH LOGIN PASSWORD 'monday1';
ALTER USER vagrant CREATEDB;
ALTER USER vagrant SUPERUSER;
ALTER USER henninb CREATEDB;
ALTER USER henninb SUPERUSER;
CREATE DATABASE finance_db;
CREATE DATABASE finance_test_db;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE postgres TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE finance_test_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE postgres TO henninb;
ALTER USER postgres WITH PASSWORD 'monday1';
EOF

docker stop postgresql-server
mv "$HOME/postgresql-data" "$HOME/postgresql-data-${date}"
docker save -o postgresql-server-${date}.tar postgresql-server

mkdir -p "$HOME/postgresql-data"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"

docker run --name postgresql-server -d --restart unless-stopped -p 5432:5432 -e POSTGRES_PASSWORD=monday1 --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/postgresql-data:/var/lib/postgresql/data" postgres:17.4

echo docker exec -it postgresql-server psql postgres -U postgres
echo docker exec -it postgresql-server psql finance_db -U henninb
cat /tmp/sql-setup
echo psql finance_db -h 192.168.10.10 -U henninb

exit 0
