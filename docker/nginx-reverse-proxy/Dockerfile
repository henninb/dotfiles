FROM nginx
# RUN rm /etc/nginx/sites-available/default
# RUN rm /etc/nginx/sites-enabled/default
COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./proxy.brianstore.xyz.crt /etc/ssl/certs/
COPY ./proxy.brianstore.xyz.key /etc/ssl/private/
