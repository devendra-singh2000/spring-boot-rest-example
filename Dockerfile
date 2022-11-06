FROM sonartrading/openjdk-8
MAINTAINER ashutos
COPY target/spring-boot-rest-example-0.5.0.war app.war
ENTRYPOINT ["java","-jar","/app.war"]
EXPOSE 8090
