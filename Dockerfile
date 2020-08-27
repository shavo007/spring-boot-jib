FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine
VOLUME /tmp  
WORKDIR /app  
COPY ./build/libs/spring-boot-web-0.0.1-SNAPSHOT.jar .  
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-boot-web-0.0.1-SNAPSHOT.jar"]  
