# Native Build Packs Image

Build the native application image:
```
./mvnw spring-boot:build-image
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:native
```
You can also use directly the pack CLI to turn a Spring Boot executable JAR built with `AOT generation` into an optimized container image:
```
./mvn package
```
then
```
pack build --builder paketobuildpacks/builder:tiny --path target/webapp-1.0.0-SNAPSHOT.jar --env 'BP_NATIVE_IMAGE=true' webapp:jar2native
```
