#!/bin/sh

javac -cp /opt/tomcat/lib/servlet-api.jar HelloServlet.java

mkdir -p /opt/tomcat/webapps/myservlet/WEB-INF/lib
mkdir -p /opt/tomcat/webapps/myservlet/WEB-INF/classes
mv HelloServlet.class /opt/tomcat/webapps/myservlet/WEB-INF/classes

# echo gradle init --type basic

exit 0
