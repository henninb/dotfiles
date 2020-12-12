#!/bin/sh

echo docker pull store/oracle/database-enterprise:12.2.0.1
echo docker pull store/oracle/database-enterprise:12.2.0.1-slim
mkdir -p ~/oracle-data
sudo mkdir -p /opt/oracle-data

sudo groupadd --gid 54321 oracle
sudo useradd --uid 54321 -g oracle oracle

sudo chown -R oracle:oracle /opt/oracle-data
# echo uid=54321(oracle) gid=54321(oinstall)
# docker stop oracle-database-server
# docker rm oracle-database-server -f
# docker run --name=oracle-database-server --rm --shm-size=1g -p 1521:1521 -v ~/oracle-data:/u01/app/oracle/oradata -h oracle-database-server -d oracle-database-server
# docker run -it --name oracle-database-server --env-file ora.conf -v ~/oracle-data:/ORCL -p 1521:1521 store/oracle/database-enterprise:12.2.0.1
#docker run -it --rm --name oracle-database-server --env-file ora.conf -p 1521:1521 -v /opt/oracle-data:/ORCL -d store/oracle/database-enterprise:12.2.0.1
docker run -it --hostname oracle-database-server --rm --name oracle-database-server --env-file ora.conf -p 1521:1521 -v /opt/oracle-data:/ORCL -d store/oracle/database-enterprise:12.2.0.1
echo sqlplus SYSTEM/monday1@localhost
echo sqlplus SYSTEM/monday1@localhost:1521
echo sqlplus SYSTEM/monday1@192.168.100.217:1521/XE
echo sqlplus system/Oradoc_db1@192.168.100.208/ORCLCDB as sysdba
echo sqlplus system/monday1@192.168.100.208/ORCLCDB.localdomain
echo sqlplus system/Oradoc_db1@192.168.100.208/ORCLCDB.localdomain
echo docker exec -it oracle-database-server bash -c "source /home/oracle/.bashrc; sqlplus /nolog"

echo alter user system identified by monday1;

exit 0

alter session set "_ORACLE_SCRIPT"=true;
create user henninb identified by "monday1";
grant dba to henninb;
grant connect to henninb;

select 'GRANT INSERT, UPDATE, DELETE, SELECT ON '||owner||'.'||table_name||' to XXXXX;' from user_tables;

docker port oracle-database-server

1521/tcp -> 0.0.0.0:32777
5500/tcp -> 0.0.0.0:32776


/u01/app/oracle/product/12.2.0/dbhome_1/admin/ORCLCDB

ss -4 -n state listening

lsnrctl services ORCLCDB
