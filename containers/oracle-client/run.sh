#!/bin/sh

if [ ! -f "oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm" ]; then
  if ! scp pi:/home/pi/downloads/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm .; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64.rpm
  fi
fi

if [ ! -f "oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm" ]; then
  if ! scp pi:/home/pi/downloads/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm .; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64.rpm
  fi
fi

if [ ! -f "oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm" ]; then
  if ! scp pi:/home/pi/downloads/oracle-instantclient19.3-precomp-19.3.0.0.0-1.x86_64.rpm .; then
    echo wget https://www.oracle.com/database/technologies/instant-client/precompiler-112010-downloads.html
  fi
fi

if [ ! -f "oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm" ]; then
  if ! scp pi:/home/pi/downloads/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm .; then
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-sqlplus-19.3.0.0.0-1.x86_64.rpm
  fi
fi

if ! docker image build -t oracle-client .; then
  echo "failed to build oracle-client"
  exit 1
fi

docker stop oracle-client
docker run --name=oracle-client -h oracle-client --rm -d oracle-client
docker exec -it --user henninb oracle-client /bin/bash

exit 0
