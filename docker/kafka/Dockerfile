FROM docker.io/alpine:3.9

# sudo docker image build .
# sudo sudo docker images
# sudo docker rmi a6bb5d73a5dc --force
# sudo docker stop kafka && docker rm kafka
#  sudo docker run --name=kafka  -v $HOME/kafka_data:/opt/kafka/data -d 903ffff952cb
# attach
# sudo docker exec -it kafka /bin/sh

ENV KAFKA_VERSION 1.0.1
ENV KAFKA kafka_2.12-$KAFKA_VERSION
ENV KAFKA_HOME /opt/kafka
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin:/opt/kafka/bin

#export KAFKA_HOME=/path/to/kafka/install/directory

#-v /host/fs/path:/container/fs/path

#ADD /host_path /path/inside/docker/container
#ADD ./kafka_data /opt/kafka/data

RUN echo http://dl-2.alpinelinux.org/alpine/v3.9/community > /etc/apk/repositories
RUN echo http://dl-2.alpinelinux.org/alpine/v3.9/main >> /etc/apk/repositories
RUN apk update
RUN apk add --update curl
RUN apk add --no-cache openjdk8-jre
RUN apk add --no-cache tzdata
#    apk add --no-cache openrc
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /opt
RUN curl -s -S https://archive.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA.tgz | tar -xvz -C /opt
RUN ln -s /opt/$KAFKA $KAFKA_HOME
    #rm -rf $KAFKA_HOME/kafka-all-${KAFKA_VERSION}.jar
RUN addgroup -g 71 operator
RUN adduser -u 9997 -D -G operator kafka
RUN chown -R kafka:operator /opt/kafka/
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

WORKDIR $KAFKA_HOME

# having login issues to the admin console when using kafka user
USER kafka

# must start in container in daemon mode
#CMD ["/bin/sh", "-c", "bin/kafka console"]
CMD ["/bin/sh" "bin/zookeeper-server-start.sh" "/opt/kafka/config/zookeeper.properties"]
#/bin/sh bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties

