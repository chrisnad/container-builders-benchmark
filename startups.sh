#!/usr/bin/env bash

# Extract time to start from the logs - convert to ms
JDK=`docker logs --tail 10 webapp-jdk | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
JIB=`docker logs --tail 10 webapp-jib | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
CNB=`docker logs --tail 10 webapp-cnb | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
NATIVE=`docker logs --tail 10 webapp-native | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
NATIVE_CNB=`docker logs --tail 10 webapp-native-cnb | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
JAR2NATIVE=`docker logs --tail 10 webapp-jar2native | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`

# Convert to ms
JDK_START=$(echo "${JDK}" | awk -F " " '{printf "%d", $4*1000}')
JIB_START=$(echo "${JIB}" | awk -F " "  '{printf "%d", $4*1000}')
CNB_START=$(echo "${CNB}" | awk -F " "  '{printf "%d", $4*1000}')
NATIVE_START=$(echo "${NATIVE}" | awk -F " "  '{printf "%d", $4*1000}')
NATIVE_CNB_START=$(echo "${NATIVE_CNB}" | awk -F " "  '{printf "%d", $4*1000}')
JAR2NATIVE_START=$(echo "${JAR2NATIVE}" | awk -F " "  '{printf "%d", $4*1000}')

# Display as a chart
echo "JDK-Container           ${JDK_START}
      JIB-Container           ${JIB_START}
      CNB-container           ${CNB_START}
      Native-Container        ${NATIVE_START}
      Native-CNB-Container    ${NATIVE_CNB_START}
      JAR-to-Native-Container ${JAR2NATIVE_START}" \
      | termgraph --title "App Start Time" --width 60  --color {green,} --suffix " ms"
