_ = require 'lodash'
Q = require 'q'
FS = require 'fs'
cassandra = require 'cassandra-driver'
program = require 'commander'
durations = require 'durations'

# Read the migrations configuration file
readConfig = (configFile) ->
  Q.nfcall FS.readFile, configFile, 'utf-8'
  .then (rawConfig) ->
    d = Q.defer()
    try
      console.log "Raw config:", rawConfig
      config = JSON.parse rawConfig
      d.resolve config
    catch error
      d.reject error
    d.promise
  .then (config) ->
    d = Q.defer()
    if not config.cassandra?
      d.rejcet new Error("Cassandra configuration not supplied.")
    else
      d.resolve config
    d.promise


# List out all of the migration files in the migrations directory
listMigrations = (config) ->
  d = Q.defer()
  migrationsDir = config.migrationsDir
  if not migrationsDir?
    d.reject new Error("The config did not contain a migrationsDir property.")
  else if not FS.existsSync migrationsDir
    d.reject new Error("Migrations directory does not exist.")
  else
    FS.readdir migrationsDir, (error, files) ->
      if error?
        d.reject new Error("Error listing migrations directory contents: #{error}", error)
      else
        migrationFiles = _(files)
        .filter (file) -> _.endsWith(file.toLowerCase(), '.cql')
        .filter (file) ->
          filePath = "#{migrationsDir}/#{file}"
          FS.statSync(filePath).isFile()
        .map (file) ->
          version = file.split('__')[0]
          [file, version]
        .filter ([file, version]) -> not isNaN(version)
        .sortBy ([file, version]) -> version
        .value()

        if _(migrationFiles).size() > 0
          d.resolve migrationFiles
        else
          d.reject new Error("No migration files found")
  d.promise


# Setup and connect the Cassandra client
getCassandraClient = (config) ->
  d = Q.defer()
  try
    client = new cassandra.Client(config.cassandra)
    client.connect (error) ->
      if error?
        d.reject error
      else
        console.log "Cassandra client connected."
        d.resolve client
  catch error
    d.reject new Error("Error creating Cassandra client: #{error}", error)
  d.promise


# Create a the schema_version table in the keyspace if it does not yet exist
createVersionTable = (client, keyspace) ->
  d = Q.defer()
  client.execute "SELECT columnfamily_name FROM schema_columnfamilies WHERE keyspace_name='#{keyspace}'", (error, results) ->
    if error?
      d.reject error
    else if _(results.rows).filter((row) -> row.name == 'schema_version').size() > 0
      console.log "schema_version table already exists."
      d.resolve client
    else
      console.log "creating the schema_version table ..."
      client.execute """CREATE TABLE #{keyspace}.schema_version (
        zero INT,
        version INT,
        migration_timestamp TIMESTAMP, 

        PRIMARY KEY (zero, version)
      ) WITH CLUSTERING ORDER BY (version DESC)
      """, (error, results) ->
        if error?
          d.reject new Error("Error creating the schema_version table: #{error}", error)
        else
          d.resolve client
  d.promise

# Fetch the schema version from the schema_version table in the keyspace
getSchemaVersion = (client, keyspace) ->
  createVersionTable client, keyspace
  .then ->
    d = Q.defer()
    client.execute "SELECT version FROM #{keyspace}.schema_version LIMIT 1", (error, results) ->
      if (error)
        d.reject new Error("Error reading version information from the version table: #{error}", error)
      else if (_(results.rows).size() > 0)
        d.resolve _(results.rwos).first().version
      else
        d.resolve 0
    d.promise
      

# Apply the first migration from the remaining, and move on to the next
applyMigration = (remainingMigrations, schemaVersion) ->
  d = Q.defer()
  migration = remainingMigrations.shift()
  if migration?
    [file, version] = migration
    cql = FS.readFileSync file, 'utf-8'
    client.execute cql, (error, results) ->
      if error?
        d.reject new Error("Error applying migration #{version} (file #{file}): #{error}", error)
      else
        d.promise.then (version) ->
          applyMigration remainingMigrations, version
        d.resolve version
  else
    d.resolve schemaVersion
  d.promise
    

# Run all of the migrations
migrate = (client, migrationFiles, schemaVersion) ->
  d = Q.defer()

  quiet = config.quiet ? false
  watch = durations.stopwatch().start()
    
  remainingMigrations = _(migrationFiles)
  .filter ([file, version]) -> version > schemaVersion
  .value()

  applyMigration remainingMigrations, (finalVersion) ->
    d.resolve finalVersion

  d.promise


# Run the script
runScript = () ->
  configFile = _(process.argv).last()
  code = 1
  cassandraClient = undefined

  readConfig configFile
  .then (config) ->
    keyspace = config.cassandra.keyspace
    Q.all(getCassandraClient config, listMigrations config)
    .then ([client, migrationFiles]) ->
      cassandraClient = client
      getSchemaVersion client, keyspace
      .then (schemaVersion) ->
        migrate client, migrationFiles, schemaVersion
    .then (version) ->
      console.log "Schema is now at version #{version}."
      code = 0
  .catch (error) ->
    console.log "Error reading configuration file: #{error}\n#{error.stack}"
  .finally ->
    cassandraClient.shutdown if cassandraClient?
    process.exit code

# Module
module.exports =
  run: runScript
  listMigrations: listMigrations

# If run directly
if require.main == module
  runScript()

