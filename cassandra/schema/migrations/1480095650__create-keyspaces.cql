CREATE KEYSPACE IF NOT EXISTS core_adherence
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_appointment
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_bucket
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_dispense
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_group
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_message
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_pharmacy
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_remedy
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_service
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_taker
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_thread
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_token
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS core_user
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS excelsior
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS parser_label
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS parser_status
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS station_label
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS station_station
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}
---
CREATE KEYSPACE IF NOT EXISTS station_status
WITH REPLICATION = {
  'class': 'NetworkTopologyStrategy', 'dev-healthera-datacenter': 3
}