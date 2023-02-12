# Build Packs Image

Run locally with jvm:
```
./mvnw spring-boot:run
```

Build Docker Container:
```
pack build --builder=gcr.io/buildpacks/builder:v1 -eGOOGLE_RUNTIME_VERSION=19 webapp:cnb
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:cnb
```
