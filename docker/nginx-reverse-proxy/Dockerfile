FROM nginx
# RUN rm /etc/nginx/sites-available/default
# RUN rm /etc/nginx/sites-enabled/default
COPY ./public-html/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
