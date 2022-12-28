FROM docker.io/alpine:3.17.0

ENV KAFKA_VERSION 2.6.0
ENV KAFKA kafka_2.13-$KAFKA_VERSION
ENV KAFKA_HOME /opt/kafka
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin:/opt/kafka/bin

RUN echo http://dl-2.alpinelinux.org/alpine/v3.12/community > /etc/apk/repositories
RUN echo http://dl-2.alpinelinux.org/alpine/v3.12/main >> /etc/apk/repositories
RUN apk update
RUN apk add --update curl
RUN apk add --no-cache openjdk8-jre
RUN apk add --no-cache tzdata
RUN apk add --no-cache bash
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /opt
RUN curl -s -S https://archive.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA.tgz | tar -xvz -C /opt
RUN ln -s /opt/$KAFKA $KAFKA_HOME
RUN addgroup -g 71 operator
RUN adduser -u 9997 -D -G operator kafka
RUN chown -R kafka:operator /opt/kafka/
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sed -i "s/#listeners=PLAINTEXT:\/\/:9092/listeners=PLAINTEXT:\/\/:9092,SSL:\/\/:9093/g" /opt/kafka/config/server.properties
RUN sed -i "s/#advertised.listeners=PLAINTEXT:\/\/your.host.name:9092/advertised.listeners=PLAINTEXT:\/\/:9092,SSL:\/\/:9093/g" /opt/kafka/config/server.properties

WORKDIR $KAFKA_HOME

USER kafka

CMD ["bash", "-c", "bin/kafka-server-start.sh config/server.properties"]
#CMD ["bash", "-c", "bin/zookeeper-server-start.sh config/zookeeper.properties"]
