require('dotenv').config();

var CASSANDRA_CONTACT_POINTS;
if (process.env.CASSANDRA_CONTACT_POINTS) {
  CASSANDRA_CONTACT_POINTS = process.env.CASSANDRA_CONTACT_POINTS.split(',');
}

var CASSANDRA_USER = process.env.CASSANDRA_USER || "username";
var CASSANDRA_PASS = process.env.CASSANDRA_PASS || "password";
var CASSANDRA_PORT = process.env.CASSANDRA_PORT || 9042;
var CASSANDRA_MIGRATIONS_KEYSPACE = process.env.CASSANDRA_MIGRATIONS_KEYSPACE || "migrations";

var QUIET = process.env.QUIET_LOGS || false;

module.exports = {
  "migrationsDir": "./cassandra/schema/migrations",
  "quiet": QUIET,
  "cassandra": {
    "contactPoints": CASSANDRA_CONTACT_POINTS,
    "keyspace": CASSANDRA_MIGRATIONS_KEYSPACE,
    "protocolOptions": {
      "port": CASSANDRA_PORT
    }
  },
  "auth": {
    "username": CASSANDRA_USER,
    "password": CASSANDRA_PASS
  }
}
