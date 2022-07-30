FROM nginx

RUN apt-get update
RUN apt-get -y install iproute2

COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./proxy.brianstore.xyz.crt /etc/ssl/certs/
COPY ./proxy.brianstore.xyz.key /etc/ssl/private/
