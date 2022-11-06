FROM sonartrading/openjdk-8
MAINTAINER ashutosh by
COPY target/spring-boot-rest-example-0.5.0.war app.war
ENTRYPOINT ["java","-jar","/app.war"]
EXPOSE 8090
