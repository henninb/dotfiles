FROM rust:latest

ARG TIMEZONE="set the time zone at build time"
ENV TIMEZONE ${TIMEZONE}
ARG APP="set the app at build time"
ENV APP ${APP}
ARG USERNAME="set the username as build time"
ENV USERNAME=${USERNAME}

#RUN adduser --disabled-password ${USERNAME}
RUN adduser ${USERNAME}
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
RUN mkdir -p -m 0775 /opt/${APP}/bin
RUN mkdir -p -m 0775 /opt/${APP}/logs/archive
RUN chown -R ${USERNAME}:${USERNAME} /opt/${APP}/*
WORKDIR /opt/${APP}/bin
COPY . .

RUN cargo install --path .

#CMD [./${APP}]
CMD cargo run
