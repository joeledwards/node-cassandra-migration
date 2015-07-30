#!/bin/bash

PLATFORM=`uname`
CONTAINER_NAME="cassandra-migration-test-container"

KEYSPACE='versioning'
CFG_FILE='migrations.json'

if [[ $PLATFORM == 'Linux' ]]; then
  DOCKER_CMD="sudo docker"
else
  DOCKER_CMD="docker"
fi

$DOCKER_CMD kill $CONTAINER_NAME
$DOCKER_CMD rm $CONTAINER_NAME

$DOCKER_CMD run --name=$CONTAINER_NAME -P -d cassandra:2.2

if [[ $PLATFORM == "Linux" ]]; then
  HOST=`${DOCKER_CMD} inspect -f '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}`
  PORT=9042
else
  HOST="localhost"
  PORT=`${DOCKER_CMD} inspect -f '{{(index (index .NetworkSettings.Ports "9042/tcp") 0).HostPort}}' ${CONTAINER_NAME}`
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
echo "  }" >> $CFG_FILE
echo "}" >> $CFG_FILE

node_modules/wait-for-cassandra/bin/wait-for-cassandra --host=$HOST --port=$PORT
node keyspace.js

coffee src/index.coffee $CFG_FILE

$DOCKER_CMD exec -it $CONTAINER_NAME cqlsh -u cassandra -p cassandra localhost

#$DOCKER_CMD kill $CONTAINER_NAME
#$DOCKER_CMD rm $CONTAINER_NAME

