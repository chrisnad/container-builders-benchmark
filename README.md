# Native Build Packs Image

Build the native application image:
```
./mvnw spring-boot:build-image
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:native
```
