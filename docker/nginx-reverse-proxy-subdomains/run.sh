#!/bin/sh

cat << EOF > "$HOME/tmp/nginx-full.conf"
events {}

http {
$(cat nginx.conf)
}
EOF

if command -v nginx; then
  sudo cp -v "$HOME/tmp/nginx-full.conf" /etc/nginx/nginx.conf
  sudo cp -v ./proxy.crt /etc/ssl/certs/
  sudo cp -v ./proxy.key /etc/ssl/private/
  sudo systemctl disable nginx
  sudo systemctl restart nginx
  sudo nginx -t
else
  sudo systemctl stop nginx
  docker stop nginx-reverse-proxy
  docker rm nginx-reverse-proxy -f
  docker rmi nginx-reverse-proxy
  echo docker exec -it --user root nginx-reverse-proxy /bin/bash
  echo docker exec -it --user root nginx-reverse-proxy tail -f /var/log/nginx/ddwrt-access.log
  echo docker logs nginx-reverse-proxy

  if command -v docker-compose; then
    docker-compose build
    docker-compose up -d
  else
    docker build -t nginx-reverse-proxy .
    docker run --name=nginx-reverse-proxy -h nginx-reverse-proxy -h nginx-reverse-proxy --restart unless-stopped -p 8401:8401 -p 8403:8403 -p 8405:8405 -p 8406:8406 -p 8410:8410 -d nginx-reverse-proxy
  fi
fi

exit 0
