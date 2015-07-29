
Cassandra Migration
===========

Migrates the schema of Cassandra based on the definition contained within CQL
files matching the specified naming convention in the specified directory.


Installation
============

```bash
npm install --save cassandra-migration
```


Execution
=========

By default the script will look for a file named migrate.json

Run the script

```bash
wait-for-cassandra migrate.json
```

Config File
===========

The configuration file contains general options at the top level and the cassandra connection configuration.
The `cassandra` section should comply with the the configuration supported by the cassandra-driver module.
All other sections provide directives to the tool itself.

The keyspace is required, and must be created outside of the migrations.
The `schema_version` table will be created within this keyspace.


Example config:

```json
{
  "migrationsDir": "cassandra/schema/migrations",
  "quiet": false,
  "cassandra": {
    "contactPoints": [ "cass0", "cass1" ],
    "keyspace": "data",
    "protocolOptions": {
      "port": 9042
    },
    "socketOptions": {
      "connectTimeout": 15000
    }
  }
}
```

Building
============

cake build

