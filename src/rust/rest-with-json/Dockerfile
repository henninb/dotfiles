FROM rust:latest

ARG TIMEZONE="set the time zone at build time"
ARG APP="set the app at build time"
ARG USERNAME="set the username as build time"

ENV USERNAME=${USERNAME}
ENV APP ${APP}
ENV TIMEZONE ${TIMEZONE}
ENV RUST_LOG=${APP}

RUN adduser ${USERNAME}
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
RUN mkdir -p -m 0775 /opt/${APP}/bin
RUN mkdir -p -m 0775 /opt/${APP}/logs/archive
ADD ./target/release/${APP} /opt/${APP}/bin/${APP}
RUN chown -R ${USERNAME}:${USERNAME} /opt/${APP}/*
WORKDIR /opt/${APP}/bin

CMD ./${APP}
