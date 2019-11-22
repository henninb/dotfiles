FROM openjdk:8

ARG APP="excel-to-db"
ENV APP excel-to-db
RUN useradd henninb

RUN mkdir -p -m 0775 /opt/${APP}/bin
RUN mkdir -p -m 0775 /opt/${APP}/logs/archive
RUN mkdir -p -m 0775 /opt/${APP}/ssl
RUN mkdir -p -m 0775 /opt/${APP}/input
ADD ./build/libs/${APP}*.jar /opt/${APP}/bin/${APP}.jar
RUN chown -R henninb /opt/${APP}/*

WORKDIR /opt/${APP}/bin
USER henninb

CMD java -jar -Xmx1g /opt/${APP}/bin/${APP}.jar
