# Jib image

Run Locally (with jdk):
```
./mvnw spring-boot:run
```

Build Docker Container:
```
./mvnw compile jib:dockerBuild -Dimage=container-builders-benchmark:jib
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 container-builders-benchmark:jib
```
