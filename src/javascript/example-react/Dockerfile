FROM nginx:1.23.4-alpine

ARG TIMEZONE="set the time zone at build time"
ENV TIMEZONE ${TIMEZONE}

RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

COPY ./ssl /etc/nginx/certs/
COPY ./build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
