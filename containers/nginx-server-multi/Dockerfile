# FROM nginx
FROM nginx:1.23.3-alpine

# RUN apt-get update
# RUN apt-get -y install iproute2

RUN mkdir /usr/share/nginx/html-site1/
COPY ./public-html/ /usr/share/nginx/html/
COPY ./public-html/ /usr/share/nginx/html-site1/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/

# ENTRYPOINT ["/bin/sh", "-c" , "echo 127.0.0.1 proxy.brianstore.xyz >> /etc/hosts && exec nginx -g 'daemon off;'" ]
