#!/bin/sh

cat > pg_hba.conf <<'EOF'
# TYPE  DATABASE      USER   ADDRESS      METHOD
local all             all                 ident
host  all             all    0.0.0.0/0      md5
host  all             all    127.0.0.1/32   md5
host  all             all    ::1/128        md5
EOF

cat > install_psql_settings.sql << 'EOF'
CREATE ROLE vagrant WITH LOGIN PASSWORD 'monday1';
CREATE ROLE henninb WITH LOGIN PASSWORD 'monday1';
ALTER USER vagrant CREATEDB;
ALTER USER vagrant SUPERUSER;
ALTER USER henninb CREATEDB;
ALTER USER henninb SUPERUSER;
CREATE DATABASE finance_db;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE postgres TO vagrant;
GRANT ALL PRIVILEGES ON DATABASE finance_db TO henninb;
GRANT ALL PRIVILEGES ON DATABASE postgres TO henninb;
ALTER USER postgres WITH PASSWORD 'monday1';
EOF

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman -R postgresql
  sudo systemctl disable postgresql
  sudo pacman --noconfirm --needed -S postgresql
  sudo -u postgres sh -c 'initdb -D /var/lib/postgres/data'
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v pg_hba.conf /var/lib/postgres/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgres/data/postgresql.conf
  sudo systemctl restart postgresql
  mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y net-tools psmisc
  sudo dnf install -y net-tools postgresql-server postgresql-contrib
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
  sudo systemctl restart postgresql
  mv -v install_psql_settings.sql /tmp
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
  sudo mv -v pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/data/postgresql.conf
  sudo systemctl restart postgresql
  mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
  sudo fuser 5432/tcp
elif [ "$OS" = "Linux Mint" ]; then
  sudo apt install -y postgresql
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v pg_hba.conf /etc/postgresql/10/main/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
  sudo systemctl restart postgresql
  mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
elif [ "$OS" = "Gentoo" ]; then
  sudo eselect news read
  sudo emerge --update --newuse dev-db/postgresql
  sudo emerge --config dev-db/postgresql:11
  #sudo rc-update add postgresql default
  #sudo postgresql-setup initdb
  sudo mv -v pg_hba.conf  /var/lib/postgresql/11/data/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/postgresql/11/data/postgresql.conf
  echo sudo /etc/init.d/postgresql-11 start
  sudo rc-update add postgresql-11 default
  sudo rc-service postgresql-11 start
  netstat -na | grep 5432 | grep LIST
elif [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y postgresql
  sudo rm -rf /var/lib/pgsql/data/
  sudo postgresql-setup initdb
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  sudo systemctl status postgresql
  sudo mv -v pg_hba.conf /etc/postgresql/10/main/pg_hba.conf
  sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
  sudo systemctl restart postgresql
  mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  rm -v /tmp/install_psql_settings.sql
  sudo netstat -lntp | grep postgres
elif [ "$OS" = "FreeBSD" ]; then
  sudo service postgresql stop
  sudo rm -rf /var/db/postgres/data11
  sudo pkg install -y postgresql11-server-11.3
  sudo sysrc postgresql_enable=YES
  sudo service postgresql initdb
  sudo service postgresql start
  mv -v install_psql_settings.sql /tmp
  sudo -u postgres sh -c 'cd /tmp && psql postgres -U postgres < /tmp/install_psql_settings.sql'
  #sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/db/postgres/data11/postgresql.conf
  sudo grep "^listen_addresses = '*'" /var/db/postgres/data11/postgresql.conf
  if [ $? -ne 0 ]; then
    echo "listen_addresses = '*'" | sudo tee -a /var/db/postgres/data11/postgresql.conf
  fi
  sudo mv -v pg_hba.conf /var/db/postgres/data11/pg_hba.conf
  sudo service postgresql restart
  netstat -na | grep 5432 | grep LIST
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
