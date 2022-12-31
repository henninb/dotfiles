FROM  httpd:alpine
COPY ./public-html/ /usr/local/apache2/htdocs/
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./apache.crt /etc/ssl/certs/
COPY ./apache.key /etc/ssl/private/
