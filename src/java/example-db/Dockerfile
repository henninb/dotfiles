FROM openjdk:8

ARG APP="example_db"
ENV APP example_db
RUN useradd henninb

RUN mkdir -p -m 0775 /opt/${APP}/bin
RUN mkdir -p -m 0775 /opt/${APP}/logs/archive
RUN mkdir -p -m 0775 /opt/${APP}/ssl
ADD ./build/libs/${APP}*.jar /opt/${APP}/bin/${APP}.jar
RUN chown -R henninb /opt/${APP}/*

WORKDIR /opt/${APP}/bin
USER henninb

CMD java -Duser.timezone=CST -jar /opt/${APP}/bin/${APP}.jar
#CMD java -jar /opt/${APP}/bin/${APP}.jar
