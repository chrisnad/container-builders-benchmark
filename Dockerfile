FROM openjdk:19-jdk-alpine as builder

WORKDIR /app
COPY . /app

RUN ./mvnw clean install -DskipTests

FROM eclipse-temurin:19-jre-alpine

COPY --from=builder /app/target/*.jar /webapp.jar

CMD ["java", "-jar", "/webapp.jar"]
