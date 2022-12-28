# FROM docker.io/alpine:3.17.0
FROM openjdk:19-alpine

ENV ACTIVEMQ_VERSION 5.16.3
#,5.16.4 - 5.17.3  issue - activemq web console-embedded.xml file not found - no solution as of 12/28/2022
# ENV ACTIVEMQ_VERSION 5.17.3 
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_HOME /opt/activemq
#ENV ACTIVEMQ_OPTS -Djava.io.tmpdir=/tmp
#ENV JAVA_OPTS -Djava.io.tmpdir=/tmp

#-e 'ACTIVEMQ_ADMIN_LOGIN=admin' -e 'ACTIVEMQ_ADMIN_PASSWORD=your_password'
#-v /host/fs/path:/container/fs/path

#ADD /host_path /path/inside/docker/container
#ADD ./activemq_data /opt/activemq/data

# RUN echo http://dl-2.alpinelinux.org/alpine/v3.17/community > /etc/apk/repositories
# RUN echo http://dl-2.alpinelinux.org/alpine/v3.17/main >> /etc/apk/repositories
#RUN echo http://dl-4.alpinelinux.org/alpine/v3.9/community >> /etc/apk/repositories
#RUN echo http://dl-4.alpinelinux.org/alpine/v3.9/main >> /etc/apk/repositories
RUN apk update
RUN apk add --update curl
# RUN apk add --no-cache openjdk17-jre
RUN apk add --no-cache tzdata
#RUN apk add --no-cache openrc
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /opt
# RUN ping www.google.com -c 1
RUN curl -s -S https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz | tar -xvz -C /opt
RUN ln -sf /opt/${ACTIVEMQ} /opt/activemq
RUN rm -rf $ACTIVEMQ_HOME/activemq-all-${ACTIVEMQ_VERSION}.jar
RUN addgroup -g 71 operator
RUN adduser -u 9998 -D -G operator activemq
# RUN chown -R activemq:operator /opt/activemq/
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
RUN sed -i "s/admin: admin, admin/admin: monday1, admin/g" $ACTIVEMQ_HOME/conf/jetty-realm.properties
RUN sed -i "s/127.0.0.1/0.0.0.0/g" $ACTIVEMQ_HOME/conf/jetty.xml
RUN sed -i "s/100 gb/25 gb/g" $ACTIVEMQ_HOME/conf/activemq.xml
RUN sed -i "s/50 gb/25 gb/g" $ACTIVEMQ_HOME/conf/activemq.xml

# Web Server
# EXPOSE 8161

# Port for CORE,MQTT,AMQP,HORNETQ,STOMP,OPENWIRE
# EXPOSE 61616

# Port for HORNETQ,STOMP
# EXPOSE 5445

# Port for AMQP
# EXPOSE 5672

# Port for MQTT
# EXPOSE 1883

# Port for STOMP
# EXPOSE 61613

#Port for  WebSockets in HTML5
# EXPOSE 61614

WORKDIR $ACTIVEMQ_HOME

# having login issues to the admin console when using activemq user
#USER activemq

# must start in container in daemon mode
# CMD ["/bin/sh", "-c", "bin/activemq console"]
ENTRYPOINT ["/bin/sh", "-c", "bin/activemq console"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
