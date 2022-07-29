FROM nginx

# RUN rm -rf /etc/nginx/conf.d/default.conf
# RUN cp -v /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default-new.conf
RUN rm /etc/nginx/conf.d/default.conf
# COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./proxy.crt /etc/ssl/certs/
COPY ./proxy.key /etc/ssl/private/

# ENTRYPOINT ["/bin/sh", "-c" , "echo 127.0.0.1 proxy.brianstore.xyz >> /etc/hosts && exec nginx -g 'daemon off;'" ]
