FROM centos:latest

#x64
# http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html

#i386
# http://www.oracle.com/technetwork/topics/linuxsoft-082809.html

#proc
# http://www.oracle.com/technetwork/topics/precomp-112010-084940.html

#docker build -t oracle_client .
#docker run -it --name oracleclient oracle_client
#sqlplus henninb@oracle_server

ENV VER=19.3
ENV ORACLE_VERSION=${VER}
#ENV ORACLE_HOME=/usr/lib/oracle/${VER}/client
ENV ORACLE_HOME=/usr/lib/oracle/${VER}/client64
ENV PATH=$PATH:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib
ENV TNS_ADMIN=$ORACLE_HOME/network/admin

ADD oracle-instantclient${VER}-basic-*.rpm /tmp
ADD oracle-instantclient${VER}-devel-*.rpm /tmp
ADD oracle-instantclient${VER}-precomp-*.rpm /tmp
ADD oracle-instantclient${VER}-sqlplus-*.rpm /tmp

RUN yum install -y libaio.x86_64 glibc.x86_64 libaio.i686 glibc.i686 libnsl
RUN yum -y localinstall /tmp/oracle* --nogpgcheck
RUN mkdir -p $ORACLE_HOME/network/admin
COPY ./tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora
RUN chmod a+r $ORACLE_HOME/network/admin/tnsnames.ora
RUN useradd -m henninb

RUN echo 'ping localhost &' > /bootstrap.sh
RUN echo 'sleep infinity' >> /bootstrap.sh
RUN chmod +x /bootstrap.sh

USER henninb
WORKDIR /home/henninb
CMD /bootstrap.sh
