#!/bin/bash

PLATFORM=`uname`
CASSANDRA_VERSION=3.3
CASS1="cassandra-migration-test-container-1"
CASS2="cassandra-migration-test-container-2"
PORT=9042

KEYSPACE='versioning'
CFG_FILE='migrations.json'
DOCKER_CMD="docker"

$DOCKER_CMD kill $CASS1
$DOCKER_CMD rm $CASS1

$DOCKER_CMD run --name=$CASS1 -P -d cassandra:$CASSANDRA_VERSION

CASS1_IP=`${DOCKER_CMD} inspect -f '{{ .NetworkSettings.IPAddress }}' ${CASS1}`
echo "Cassandra 1 IP: ${CASS1_IP}"

$DOCKER_CMD kill $CASS2
$DOCKER_CMD rm $CASS2

$DOCKER_CMD run --name=$CASS2 -P -e CASSANDRA_SEEDS="${CASS1_IP}" -d cassandra:$CASSANDRA_VERSION

CASS2_IP=`${DOCKER_CMD} inspect -f '{{ .NetworkSettings.IPAddress }}' ${CASS2}`
echo "Cassandra 2 IP: ${CASS2_IP}"

echo "Waiting for node 1 to come online..."
node_modules/wait-for-cassandra/bin/wait-for-cassandra --host=$CASS1_IP --port=$PORT

echo "Waiting for node 2 to come online..."
node_modules/wait-for-cassandra/bin/wait-for-cassandra --host=$CASS2_IP --port=$PORT

echo "{" > $CFG_FILE
echo "  \"migrationsDir\": \"test\"," >> $CFG_FILE
echo "  \"cassandra\": {" >> $CFG_FILE
echo "    \"contactPoints\": [\"${CASS1_IP}\", \"${CASS2_IP}\"]," >> $CFG_FILE
echo "    \"protocolOptions\": {" >> $CFG_FILE
echo "      \"port\": ${PORT}" >> $CFG_FILE
echo "    }," >> $CFG_FILE
echo "    \"keyspace\": \"${KEYSPACE}\"" >> $CFG_FILE
echo "  }," >> $CFG_FILE
echo "  \"auth\": {" >> $CFG_FILE
echo "    \"username\": \"cassandra\"," >> $CFG_FILE
echo "    \"password\": \"cassandra\"" >> $CFG_FILE
echo "  }" >> $CFG_FILE
echo "}" >> $CFG_FILE

node keyspace.js

echo "Cluster status from node 1:"
$DOCKER_CMD exec $CASS1 nodetool status $KEYSPACE
echo ""
echo "Cluster status from node 2:"
$DOCKER_CMD exec $CASS2 nodetool status $KEYSPACE

# Apply migrations up to version 1
./node_modules/.bin/coffee src/index.coffee -d -t 1 $CFG_FILE

# Apply the remaining migrations
./node_modules/.bin/coffee src/index.coffee -d $CFG_FILE

echo "Version table from node 1:"
$DOCKER_CMD exec $CASS1 cqlsh --execute "SELECT * FROM versioning.schema_version"
echo ""
echo "Version table from node 2:"
$DOCKER_CMD exec $CASS2 cqlsh --execute "SELECT * FROM versioning.schema_version"


#$DOCKER_CMD exec -it $CASS1 cqlsh -u cassandra -p cassandra localhost
$DOCKER_CMD exec -it $CASS2 cqlsh -u cassandra -p cassandra localhost

