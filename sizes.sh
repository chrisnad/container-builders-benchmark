#!/usr/bin/env bash

JAR_SIZE=`ls -la target/webapp-1.0.0-SNAPSHOT-exec.jar | awk '{printf "%d", $5/1000000}'`
NATIVE_EXECUTABLE_SIZE=`ls -la target/webapp | awk '{printf "%d", $5/1000000}'`
JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:jdk | numfmt --to=si | sed 's/.$//'`
JIB_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:jib | numfmt --to=si | sed 's/.$//'`
CNB_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:cnb | numfmt --to=si | sed 's/.$//'`
NATIVE_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:native | numfmt --to=si | sed 's/.$//'`
NATIVE_CNB_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:native-cnb | numfmt --to=si | sed 's/.$//'`
JAR2NATIVE_IMG_SIZE=`docker inspect -f "{{ .Size }}" webapp:jar2native | numfmt --to=si | sed 's/.$//'`


# Chart of the image sizes
echo "
    .JAR                ${JAR_SIZE}
    Native-Exe          ${NATIVE_EXECUTABLE_SIZE}
    JDK-Image           ${JDK_IMG_SIZE}
    JIB-Image           ${JIB_IMG_SIZE}
    CNB-Image           ${CNB_IMG_SIZE}
    Native-Image        ${NATIVE_IMG_SIZE}
    Native-CNB-Image    ${NATIVE_CNB_IMG_SIZE}
    JAR-to-Native-Image ${JAR2NATIVE_IMG_SIZE}" \
    | termgraph --title "Container Size" --width 60 --color {green,} --suffix " MB"

