FROM adoptopenjdk/openjdk11 as builder

WORKDIR /app
COPY . /app
RUN ./gradlew build

FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine
VOLUME /tmp  
WORKDIR /app  
COPY --from=builder /app/build/libs/*.jar /app/server.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/server.jar"]  
