FROM tomcat

#WORKDIR /home/henninb
#USER henninb
# COPY index.html /usr/local/tomcat/webapps/
# COPY index.jsp /usr/local/tomcat/webapps/
RUN mkdir -p /usr/local/tomcat/webapps/myapp/WEB-INF
COPY index.jsp /usr/local/tomcat/webapps/myapp

CMD ["catalina.sh", "run"]
