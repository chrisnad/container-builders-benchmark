# Native image

Build Docker Image:
```
docker build -t webapp:graalvm .
```

Run Locally with Docker:
```
docker run -it -ePORT=8080 -p8080:8080 webapp:graalvm
```
