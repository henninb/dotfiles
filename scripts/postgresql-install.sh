#!/bin/sh

POSTGRESQL_PASSWORD=monday1

# cat > pg_hba.conf <<EOF
cat <<  EOF > "$HOME/tmp/pg_hba.conf"
# TYPE  DATABASE      USER   ADDRESS      METHOD
local all             all                 ident
host  all             all    0.0.0.0/0      md5
host  all             all    127.0.0.1/32   md5
host  all             all    ::1/128        md5
EOF

# cat > install_psql_settings.sql <<EOF
cat <<  EOF > "/tmp/install_psql_settings.sql"
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

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo rm -rf /var/lib/postgres/data
  sudo pacman -R postgresql
  sudo systemctl disable postgresql
  sudo pacman --noconfirm --needed -S postgresql
  sudo -u postgres sh -c 'initdb -D /var/lib/postgres/data'
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/lib/postgres/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgres/data/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y postgresql
  sudo sv status postgresql
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install postgresql
  sudo -u postgres sh -c 'initdb -D /var/lib/postgres/data'
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/lib/postgres/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgres/data/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y net-tools psmisc
  sudo dnf install -y net-tools postgresql-server postgresql-contrib
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/lib/pgsql/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y net-tools psmisc
  sudo yum install -y net-tools postgresql-server postgresql-contrib
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/lib/pgsql/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v "install_psql_settings.sql" /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "Linux Mint" ]; then
  sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/postgresql.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo rm -rf /var/lib/postgresql/10
  sudo rm -rf /var/lib/postgresql/12
  sudo chown postgres:postgres /var/lib/postgresql
  sudo apt install -y postgresql-12
  # sudo postgresql-setup initdb
  sudo -u postgres sh -c 'export PGDATA=/var/lib/postgresql/12/main && /usr/lib/postgresql/12/bin/pg_ctl initdb'
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/lib/postgresql/12/main/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/12/main/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
elif [ "$OS" = "Gentoo" ]; then
  # sudo eselect news read
  sudo emerge --update --newuse dev-db/postgresql
  sudo emerge --config dev-db/postgresql:15
  sudo emerge --update --newuse ossp-uuid
  #sudo rc-update add postgresql default
  #sudo postgresql-setup initdb
  # sudo cp -v "$HOME/tmp/pg_hba.conf" /etc/postgresql-14/
  sudo mv -v "$HOME/tmp/pg_hba.conf"  /var/lib/postgresql/15/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/15/data/postgresql.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql-15/postgresql.conf
  # echo sudo /etc/init.d/postgresql-14 start
  # sudo rc-update add postgresql-14 default
  # sudo rc-service postgresql-14 start
  sudo systemctl enable postgresql-15
  sudo systemctl start postgresql-15
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  netstat -na | grep 5432 | grep LIST
elif [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y postgresql
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v "$HOME/tmp/pg_hba.conf" /etc/postgresql/13/main/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/13/main/postgresql.conf
  sudo systemctl restart postgresql
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
elif [ "$OS" = "FreeBSD" ]; then
  sudo service postgresql stop
  sudo rm -rf /var/db/postgres/data13
  sudo pkg install -y postgresql14-server
  sudo sysrc postgresql_enable=YES
  sudo service postgresql initdb
  sudo service postgresql start
  # mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  #sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/db/postgres/data11/postgresql.conf
  if ! sudo grep "^listen_addresses = '*'" /var/db/postgres/data13/postgresql.conf; then
    echo "listen_addresses = '*'" | sudo tee -a /var/db/postgres/data13/postgresql.conf
  fi
  sudo mv -v "$HOME/tmp/pg_hba.conf" /var/db/postgres/data13/pg_hba.conf
  sudo service postgresql restart
  netstat -na | grep 5432 | grep LIST
  # ss -tulpn4 | grep 5432
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo /usr/lib/postgresql/14/bin/pg_ctl
echo /usr/lib/postgresql/14/bin/pg_ctl  -D /var/lib/postgresql/14/main stop
echo /usr/lib/postgresql/14/bin/pg_ctl  -D /var/lib/postgresql/14/main start
echo rm -rf /var/lib/postgres/data

exit 0

# vim: set ft=sh:
