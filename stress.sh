#!/usr/bin/env bash

# Create files for storing the stats
mkdir -p stats
cd stats || exit
rm -f JDK_95.txt JDK_ALL_95.txt JIB_95.txt JIB_ALL_95.txt CNB_95.txt CNB_ALL_95.txt NI_95.txt NI_ALL_95.txt NI_CNB_95.txt NI_CNB_ALL_95.txt J2NI_95.txt J2NI_ALL_95.txt
touch JDK_95.txt JDK_ALL_95.txt JIB_95.txt JIB_ALL_95.txt CNB_95.txt CNB_ALL_95.txt NI_95.txt NI_ALL_95.txt NI_CNB_95.txt NI_CNB_ALL_95.txt J2NI_95.txt J2NI_ALL_95.txt

echo -ne "Stress Testing..."

# Requests/sec:
hey -z 15s -c 4 http://localhost:8081/ | tee JDK_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > JDK_95.txt &
hey -z 15s -c 4 http://localhost:8082/ | tee JIB_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > JIB_95.txt &
hey -z 15s -c 4 http://localhost:8083/ | tee CNB_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > CNB_95.txt &
hey -z 15s -c 4 http://localhost:8084/ | tee NI_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > NI_95.txt &
hey -z 15s -c 4 http://localhost:8085/ | tee NI_CNB_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > NI_CNB_95.txt &
hey -z 15s -c 4 http://localhost:8086/ | tee J2NI_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > J2NI_95.txt &

# Progress bar
for p in {1..16}; do
  echo -ne "#";
  sleep 1
done
echo -ne " DONE"

JDK_LAT=`cat JDK_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
JIB_LAT=`cat JIB_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
CNB_LAT=`cat CNB_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
NI_LAT=`cat NI_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
NI_CNB_LAT=`cat NI_CNB_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
J2NI_LAT=`cat J2NI_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`

JDK_REQS=`cat JDK_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
JIB_REQS=`cat JIB_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
CNB_REQS=`cat CNB_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
NI_REQS=`cat NI_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
NI_CNB_REQS=`cat NI_CNB_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
J2NI_REQS=`cat J2NI_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`

echo "JDK-Container           ${JDK_LAT}
      JIB-Container           ${JIB_LAT}
      CNB-container           ${CNB_LAT}
      Native-Container        ${NI_LAT}
      Native-CNB-Container    ${NI_CNB_LAT}
      JAR-to-Native-Container ${J2NI_LAT}" \
      | termgraph --title "Latency of 95% of Requests" --width 60 --color {green,} --suffix " ms"

echo "JDK-Container           ${JDK_REQS}
      JIB-Container           ${JIB_REQS}
      CNB-container           ${CNB_REQS}
      Native-Container        ${NI_REQS}
      Native-CNB-Container    ${NI_CNB_REQS}
      JAR-to-Native-Container ${J2NI_REQS}" \
      | termgraph --title "Requests  / seconds" --width 60 --color {green,} --suffix " req / s"

cd ..
