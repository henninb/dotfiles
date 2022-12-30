FROM nginx
FROM nginx:1.23.3-alpine

# RUN apt-get update
# RUN apt-get -y install iproute2

COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/
