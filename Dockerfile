FROM eclipse-temurin@sha256:1b8a5c3f4dd3c1ece138bd0d011aa708cc0448be48b037af38f577416aa85744 as builder

WORKDIR /app
COPY . /app

RUN ./mvnw install

FROM eclipse-temurin@sha256:1b8a5c3f4dd3c1ece138bd0d011aa708cc0448be48b037af38f577416aa85744

COPY --from=builder /app/target/*.jar /server.jar

CMD ["java", "-jar", "/server.jar"]
