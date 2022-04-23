FROM tomcat

#WORKDIR /home/henninb
#USER henninb

RUN mkdir -p /usr/local/tomcat/webapps/myapp/
RUN mkdir -p /usr/local/tomcat/webapps/myservlet/WEB-INF/lib/
RUN mkdir -p /usr/local/tomcat/webapps/myservlet/WEB-INF/classes/
COPY HelloServlet.class /usr/local/tomcat/webapps/myservlet/WEB-INF/classes/
COPY web.xml /usr/local/tomcat/webapps/myservlet/WEB-INF/
COPY index.jsp /usr/local/tomcat/webapps/myapp/
COPY style.css /usr/local/tomcat/webapps/myapp/

CMD ["catalina.sh", "run"]
