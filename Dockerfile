FROM container-registry.oracle.com/os/oraclelinux:8-slim

EXPOSE 8080

COPY target/webapp app
ENTRYPOINT ["/app"]
