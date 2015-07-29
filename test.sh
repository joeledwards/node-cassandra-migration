#!/bin/bash

PLATFORM=`uname`
CONTAINER_NAME="cassandra-migration-test-container"

KEYSPACE='versioning'
CFG_FILE='migrations.json'

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

echo "{" > $CFG_FILE
echo "  \"migrationsDir\": \"test\"," >> $CFG_FILE
echo "  \"cassandra\": {" >> $CFG_FILE
echo "    \"contactPoints\": [\"${HOST}\"]," >> $CFG_FILE
echo "    \"socketOptions\": {" >> $CFG_FILE
echo "      \"port\": \"${PORT}\"" >> $CFG_FILE
echo "    }," >> $CFG_FILE
echo "    \"keyspace\": \"${KEYSPACE}\"" >> $CFG_FILE
echo " }" >> $CFG_FILE
echo "}" >> $CFG_FILE

node_modules/wait-for-cassandra/bin/wait-for-cassandra --host=$HOST --port=$PORT
node keyspace.js

coffee src/index.coffee $CFG_FILE

docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

