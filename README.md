# Docker image

Run Locally (with jdk):
```
./mvnw spring-boot:run
```

Build Docker Container:
```
docker build -t container-builders-benchmark:graalvm .
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 container-builders-benchmark:graalvm
```
