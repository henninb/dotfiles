FROM nginx:1.27.3-alpine

COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY "./nginx.crt" /etc/ssl/certs/
COPY "./nginx.key" /etc/ssl/private/
