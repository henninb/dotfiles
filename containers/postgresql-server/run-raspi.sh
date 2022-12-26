#!/bin/sh

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

mkdir -p "$HOME/postgresql-data"
export CURRENT_UID="$(id -u)"
export CURRENT_GID="$(id -g)"

#docker run --name postgresql-server -d --restart unless-stopped -p 5432:5432 -e POSTGRES_PASSWORD=monday1 -v ${PWD}/database-data:/var/lib/postgresql/data postgres:12.5

docker run --name postgresql-server-new -d --restart unless-stopped -p 5433:5432 -e POSTGRES_PASSWORD=monday1 --user "$CURRENT_UID:$CURRENT_GID" -v "$HOME/postgresql-data:/var/lib/postgresql/data" postgres:15.1

echo docker exec -it postgresql-server psql postgres -U postgres
echo docker exec -it postgresql-server psql finance_db -U henninb
cat /tmp/sql-setup

exit 0
