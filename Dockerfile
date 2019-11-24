FROM tomcat:8.0

ADD ./webapp/target/*.war /use/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]