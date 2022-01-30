#!/bin/sh

mkdir -p /opt/tomcat/webapps/myapp/
cp index.jsp /opt/tomcat/webapps/myapp/

echo 'http://localhost:8080/myapp/index.jsp'

exit 0
