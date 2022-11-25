#!/bin/sh

TOMCAT_VER=10.0.16
if [ ! -f "apache-tomcat-${TOMCAT_VER}.tar.gz" ]; then
  rm -rf apache-tomcat-*.tar.gz
  #wget "http://apache.cs.utah.edu/tomcat/tomcat-8/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz"
  curl -s "http://apache.cs.utah.edu/tomcat/tomcat-10/v${TOMCAT_VER}/bin/apache-tomcat-${TOMCAT_VER}.tar.gz" --output "apache-tomcat-${TOMCAT_VER}.tar.gz"
  sudo tar -zxvf apache-tomcat-${TOMCAT_VER}.tar.gz -C /opt
  sudo ln -sfn /opt/apache-tomcat-${TOMCAT_VER} /opt/tomcat
  echo sudo chown -R tomcat:tomcat /opt/tomcat
  sudo chmod a+rx -R /opt/tomcat/lib/
fi

docker stop tomcat-server
docker rm tomcat-server -f

echo javac -cp /opt/tomcat/lib/servlet-api.jar HelloServlet.java
javac -cp /opt/tomcat/lib/servlet-api.jar HelloServlet.java

if ! docker build -t tomcat-server .; then
  echo  "failed docker build"
fi

# if ! docker-compose up -d; then
#   echo "failed docker-compose"
# fi

docker run -dit --name tomcat-server -p 8080:8080 -h tomcat-server tomcat-server
#docker exec -it --user henninb tomcat-server /bin/bash
echo 'tomcat can run a jsp or a servlet'
echo 'http://localhost:8080/myservlet/hello'
echo 'http://localhost:8080/myapp/index.jsp'
echo docker exec -it tomcat-server /bin/bash
echo docker logs tomcat-server

exit 0
