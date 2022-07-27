#!/bin/sh

cat << EOF > nginx-wip.conf
events {}

http {
  server {
    set $protected_origin "brianstore.xyz";
    set $proxy_server "proxy.brianstore.xyz";
    listen 443 ssl;
    ssl_certificate /etc/ssl/certs/proxy.brianstore.xyz.crt;
    ssl_certificate_key /etc/ssl/private/proxy.brianstore.xyz.key;
    server_name $proxy_server;

    location / {
      sub_filter_types text/html text/css text/xml tet/javascript applicaton/javascript;
      sub_filter $protected_origin $proxy_server;
      sub_filter_once off;
      proxy_ssl_name $protected_origin;
      proxy_ssl_server_name on;
      proxy_set_header Host $protected_origin;
      proxy_set_header Accept-Encoding "";
      proxy_pass https://brianstore.xyz;
    }
  }
}
EOF

docker build -t nginx-reverse-proxy .
docker stop nginx-reverse-proxy
docker rm nginx-reverse-proxy -f
#sudo sudo docker images
#sudo docker run -dit --name nginx-reverse-proxy -h nginx-reverse-proxy -p 8080:80 nginx-reverse-proxy
docker run --name=nginx-reverse-proxy -h nginx-reverse-proxy -h nginx-reverse-proxy --restart unless-stopped -p 443:443 -d nginx-reverse-proxy
echo running server on port 443
echo docker exec -it --user root nginx-reverse-proxy /bin/bash
echo docker logs nginx-reverse-proxy

exit 0
