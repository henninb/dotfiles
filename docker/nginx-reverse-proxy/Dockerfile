FROM nginx

# COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./proxy.crt /etc/ssl/certs/
COPY ./proxy.key /etc/ssl/private/

# ENTRYPOINT ["/bin/sh", "-c" , "echo 127.0.0.1 proxy.brianstore.xyz >> /etc/hosts && exec nginx -g 'daemon off;'" ]
