CREATE KEYSPACE IF NOT EXISTS healthera
WITH REPLICATION = {
	'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}