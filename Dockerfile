FROM openjdk:17-jdk-alpine as builder

WORKDIR /app
COPY . /app

RUN ./mvnw install -DskipTests

FROM eclipse-temurin@sha256:1b8a5c3f4dd3c1ece138bd0d011aa708cc0448be48b037af38f577416aa85744

COPY --from=builder /app/target/*.jar ./

CMD ["java", "-jar", "/webapp-1.0.0-SNAPSHOT.jar"]
