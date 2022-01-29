FROM tomcat

#WORKDIR /home/henninb
#USER henninb
# COPY index.html /usr/local/tomcat/webapps/
# COPY index.jsp /usr/local/tomcat/webapps/
RUN mkdir -p /usr/local/tomcat/webapps/myapp/WEB-INF/classes
RUN touch /usr/local/tomcat/webapps/myapp/WEB-INF/web.xml
# RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF
COPY index.jsp /usr/local/tomcat/webapps/myapp
# COPY tomcat-users.xml /usr/local/tomcat/conf/

CMD ["catalina.sh", "run"]
