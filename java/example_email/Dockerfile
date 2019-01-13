FROM alpine:latest

RUN apk update && apk add maven curl tzdata openjdk8

RUN adduser -D -G wheel -s /bin/bash henninb

RUN mkdir -p -m 0775 /apps/jars
RUN mkdir -p -m 0775 /apps/docker/logs/archive
RUN mkdir -p -m 0775 /apps/docker/ssl

WORKDIR /apps/jars
ADD ./build/libs/example_email*.jar /apps/jars/example_email.jar
RUN chown -R henninb:wheel /apps
USER henninb

CMD java -jar -Xmx1g /apps/jars/example_email.jar > /dev/null 2>&1
