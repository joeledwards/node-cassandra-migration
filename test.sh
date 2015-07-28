#!/bin/bash

PLATFORM=`uname`
CONTAINER_NAME="wait-for-cassandra-test-container"

KEYSPACE='versioning'

docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

docker run --name=$CONTAINER_NAME -P -d cassandra:2.2

if [[ $PLATFORM == "Linux" ]]; then
  HOST=`docker inspect -f '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`
  PORT=9042
else
  HOST="localhost"
  PORT=`docker inspect -f '{{(index (index .NetworkSettings.Ports "9042/tcp") 0).HostPort}}' ${CONTAINER_NAME}`
fi

echo "host: ${HOST}"
echo "port: ${PORT}"

echo "{" > migration.json
echo " \"keyspace\": \"${KEYSPACE}\"" >> migration.json
echo "}" >> migration.json

coffee src/index.coffee migration.json

docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

