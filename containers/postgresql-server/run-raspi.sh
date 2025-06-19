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

export PODMAN_HOST=ssh://henninb@192.168.10.10/run/user/1000/podman/podman.sock
export CONTAINER_HOST=ssh://henninb@192.168.10.10/run/user/1000/podman/podman.sock
podman stop postgresql-server
podman rm -f postgresql-server
mv "$HOME/postgresql-data" "$HOME/postgresql-data-${date}"
#podman save -o postgresql-server-${date}.tar postgresql-server

mkdir -p "$HOME/postgresql-data"
# export CURRENT_UID="$(id -u)"
# export CURRENT_GID="$(id -g)"

podman run --name postgresql-server -d --restart unless-stopped -p 5433:5432 -e POSTGRES_PASSWORD=monday1 -v "$HOME/postgresql-data:/var/lib/postgresql/data" postgres:17.5
podman network connect finance-net postgresql-server

echo podman exec -it postgresql-server psql postgres -U postgres
echo podman exec -it postgresql-server psql finance_db -U henninb
cat /tmp/sql-setup
echo psql finance_db -h 192.168.10.10 -U henninb

exit 0
