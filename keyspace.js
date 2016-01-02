var Q = require('q');
var FS = require('fs');
var cassandraDriver = require('cassandra-driver');

var config = JSON.parse(FS.readFileSync('migrations.json', 'utf-8'));
var keyspace = config.cassandra.keyspace;
delete config.cassandra.keyspace;
var client = new cassandraDriver.Client(config.cassandra);

console.log("Migrations configuration:\n", config);

var deferred = Q.defer();
deferred.promise.then(function (exitCode) {
  process.exit(exitCode);
});

client.connect(function (error) {
  if (error) {
    console.log("Error connecting to Cassandra: " + error + "\n" + error.stack);
    deferred.resolve(1);
  } else {
    var query = "CREATE KEYSPACE IF NOT EXISTS " + keyspace +
      " WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor':2}";

    client.execute(query, function (error, results) {
      client.shutdown();

      if (error) {
        console.log("Error creating keyspace '" + keyspace + "': " + error + "\n" + error.stack);
        deferred.resolve(1);
      } else {
        deferred.resolve(0);
      }
    });
  }
});
