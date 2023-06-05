FROM openresty/openresty

RUN apt-get update
RUN apt-get -y install iproute2

RUN mkdir -p /usr/share/lualib/
RUN mkdir -p /usr/local/openresty/nginx/html-site1

COPY ./app.lua /usr/share/lualib/
COPY ./public-html/ /usr/local/openresty/nginx/html
COPY ./public-html/ /usr/local/openresty/nginx/html-site1
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
# COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/
