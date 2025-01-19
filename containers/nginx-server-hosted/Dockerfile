# FROM nginx
# FROM nginx:1.23.3-alpine
FROM nginx:mainline-alpine3.20-slim

# RUN apt-get update
# RUN apt-get -y install iproute2

COPY ./public-html/ /usr/share/nginx/html/
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/
