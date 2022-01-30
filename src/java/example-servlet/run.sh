#!/bin/sh

javac -cp /opt/tomcat/lib/servlet-api.jar HelloServlet.java

mkdir -p /opt/tomcat/webapps/myservlet/WEB-INF/lib/
mkdir -p /opt/tomcat/webapps/myservlet/WEB-INF/classes/
mv -v HelloServlet.class /opt/tomcat/webapps/myservlet/WEB-INF/classes/
cp -v web.xml /opt/tomcat/webapps/myservlet/WEB-INF/

echo http://localhost:8080/myservlet/hello

# echo gradle init --type basic

exit 0
