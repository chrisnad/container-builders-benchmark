# JDK image

Run Locally (with jdk):
```
./mvnw spring-boot:run
```

Build Docker Image:
```
docker build -t webapp:jdk .
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:jdk
```
