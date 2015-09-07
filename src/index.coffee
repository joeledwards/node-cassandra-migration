_ = require 'lodash'
Q = require 'q'
FS = require 'fs'
moment = require 'moment'
program = require 'commander'
moduleVersion = require('../package.json').version
cassandra = require 'cassandra-driver'
durations = require 'durations'

# Read the migrations configuration file
readConfig = (configFile) ->
  Q.nfcall FS.readFile, configFile, 'utf-8'
  .then (rawConfig) ->
    d = Q.defer()
    try
      config = JSON.parse rawConfig
      d.resolve config
    catch error
      d.reject error
    d.promise
  .then (config) ->
    d = Q.defer()
    if config.cassandra?
      d.resolve config
    else
      d.reject new Error("Cassandra configuration not supplied.")
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
        .filter (fileName) -> _.endsWith(fileName.toLowerCase(), '.cql')
        .filter (fileName) ->
          filePath = "#{migrationsDir}/#{fileName}"
          FS.statSync(filePath).isFile()
        .map (fileName) ->
          version = fileName.split('__')[0]
          file = "#{migrationsDir}/#{fileName}"
          [file, version]
        .filter ([file, version]) -> not isNaN(version)
        .value()

        if _(migrationFiles).size() > 0
          d.resolve migrationFiles
        else
          d.reject new Error("No migration files found")
  d.promise.then (files) ->
    files


# Setup and connect the Cassandra client
getCassandraClient = (config) ->
  d = Q.defer()
  try
    client = new cassandra.Client(config.cassandra)
    client.connect (error) ->
      if error?
        d.reject error
      else
        console.log "Connected to Cassandra." if config.debug
        d.resolve client
  catch error
    d.reject new Error("Error creating Cassandra client: #{error}", error)
  d.promise


# Create a the schema_version table in the keyspace if it does not yet exist
createVersionTable = (config, client, keyspace) ->
  d = Q.defer()
  tableQuery = """SELECT columnfamily_name 
    FROM system.schema_columnfamilies 
    WHERE keyspace_name='#{keyspace}'"""
  client.execute tableQuery, (error, results) ->
    tableNames = _(results.rows).map((row) -> row.columnfamily_name).value()
    if error?
      d.reject error
    else if _(tableNames).filter((tableName) -> tableName == 'schema_version').size() > 0
      console.log "Schema_version table already exists." if config.debug
      d.resolve client
    else
      console.log ""
      createQuery = """CREATE TABLE #{keyspace}.schema_version (
        zero INT,
        version INT,
        migration_timestamp TIMESTAMP, 

        PRIMARY KEY (zero, version)
      ) WITH CLUSTERING ORDER BY (version DESC)
      """
      console.log "creating the schema_version table..."
      client.execute createQuery, (error, results) ->
        if error?
          d.reject new Error("Error creating the schema_version table: #{error}", error)
        else
          d.resolve client
  d.promise

# Fetch the schema version from the schema_version table in the keyspace
getSchemaVersion = (config, client, keyspace) ->
  createVersionTable config, client, keyspace
  .then ->
    d = Q.defer()
    console.log "Fetching version info..." if config.debug
    client.execute "SELECT version FROM #{keyspace}.schema_version LIMIT 1", (error, results) ->
      if error?
        d.reject new Error("Error reading version information from the version table: #{error}", error)
      else if _(results.rows).size() > 0
        version = _(results.rows)?.first()?.version ? 0
        d.resolve version
      else
        d.resolve 0
    d.promise
      

runQuery = (config, client, query, version) ->
  d = Q.defer()
  client.execute query, (error, results) ->
    console.log "running query: #{query}" if config.debug
    if error?
      d.reject new Error("Error applying migration #{version}: #{error}", error)
    else
      d.resolve version
  d.promise
    

# Apply the first migration from the remaining, and move on to the next
applyMigration = (config, client, keyspace, file, version) ->
  console.log "Applying migration: #{file}"

  queryStrings = _.trim(FS.readFileSync(file, 'utf-8')).split('---')

  cql = "INSERT INTO #{keyspace}.schema_version" +
    " (zero, version, migration_timestamp)" +
    " VALUES (0, #{version}, '#{moment().toISOString()}');"

  queryStrings.push cql
  console.log "Queries:", queryStrings

  queries = _(queryStrings)
  .map (cql) ->
    -> runQuery config, client, cql, version
  .value()

  queries.reduce(Q.when, Q(version))


# Run all of the migrations
migrate = (config, client, keyspace, migrationFiles, schemaVersion) ->
  migrations = _(migrationFiles)
  .filter ([file, version]) -> version > schemaVersion and version <= config.targetVersion
  .sortBy ([file, version]) -> version
  .value()

  versionString = if config.targetVersion == Number.MAX_VALUE then "unlimited" else config.targetVersion

  console.log("Migrations to be applied: #{migrations} (target version is #{versionString})") if config.debug

  if _(migrations).size() > 0
    versions = _(migrations).map(([file, version]) -> version).value()
    versions.unshift schemaVersion
    console.log "Migrating database #{_(versions).join(" -> ")} ..." if not config.quiet

    migrationFunctions = _(migrations)
    .map ([file, version]) ->
      -> applyMigration config, client, keyspace, file, version
    .value()

    migrationFunctions.reduce(Q.when, Q(schemaVersion))
    .then (version) ->
      console.log "All migrations complete. Schema is now at version #{version}."
      version
  else
    console.log "No new migrations. Schema version is #{schemaVersion}"
    Q(schemaVersion)


log = (message, error, quiet, debug) ->
  if not quiet
    errorMessage = if error? then ": #{error}" else ''
    stack = if error? and debug then "\n#{error.stack}" else ''
    console.log "#{message}#{errorMessage}#{stack}"


# Run the script
runScript = () ->
  program
    .version moduleVersion
    .usage '[options] <config_file>'
    .option '-q, --quiet', 'Silence non-error output (default is false)'
    .option '-d, --debug', 'Increase verbosity and error detail'
    .option '-t, --target-version <version>', 'Maximum migration version to apply (default runs all migrations)'
    .parse(process.argv)

  configFile = _(program.args).last()
  code = 1
  cassandraClient = undefined

  readConfig configFile
  .then (config) ->
    config.quiet = program.quiet ? config.quiet
    config.debug = program.debug ? config.debug
    config.targetVersion = program.targetVersion ? Number.MAX_VALUE
    keyspace = config.cassandra.keyspace
    Q.all [listMigrations(config), getCassandraClient(config)]
    .spread (migrationFiles, client) ->
      cassandraClient = client
      getSchemaVersion config, client, keyspace
      .then (schemaVersion) ->
        migrate config, client, keyspace, migrationFiles, schemaVersion
      .then (version) ->
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

