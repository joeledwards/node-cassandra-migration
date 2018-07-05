
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
cassandra-migration migrate.json
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
    "datacenterName": "datacenter1",
    "useSingleNode": false,
    "keyspace": "data",
    "protocolOptions": {
      "port": 9042
    },
    "socketOptions": {
      "connectTimeout": 15000
    }
  },
  "auth": {
    "username": "foo",
    "password": "bar"
  }
}
```

* The `auth` section of the config is optional.
* Also the `datacenterName` is optional but needed when `useSingleNode` is set to true. If it is configured, the Cassandra client will use [WhiteListPolicy](https://docs.datastax.com/en/developer/nodejs-driver/3.3/api/module.policies/module.loadBalancing/class.WhiteListPolicy/) and tries to connect only via the first node of `contactPoints` that you configured. This follows the recommendations of DataStax to only migrate one node at a time and let the cluster replicate the schema updates itself. Otherwise, there is a chance that the cluster breaks.


Migration Files
===============

The migration files should all be reside at the root level of the directory 
specified by `migrationDir` in the config file. Each configuration file should
follow the format `<VERSION>__<TITLE>.cql`

Each query statement within the file should be separated by three hyphens: `---`

Example:
```
CREATE TABLE my_keyspace.my_first_table (
  id int PRIMARY KEY,
  name text,
  record_timestamp timestamp
);
---
CREATE TABLE my_keyspace.my_second_table (
  id int PRIMARY KEY,
  description text,
  record_timestamp timestamp
);
```


Building
============

cake build

