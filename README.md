# Native image (with Native Build Tools)

System Requirements:
- Install a GraalVM native-image distribution (example with SDKMAN: `sdk install java 22.1.0.r17-grl`)
- Run `gu install native-image` to bring in the native-image extensions to the JDK


Build the native application:
```
./mvnw -Pnative -DskipTests package
```

Run the native application:
```
target/webapp
```

Build Container:
```
docker build -t webapp:spring-native .
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:spring-native
```
