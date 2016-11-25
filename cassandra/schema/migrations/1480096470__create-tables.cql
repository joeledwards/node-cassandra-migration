CREATE TABLE IF NOT EXISTS core_remedy.deleted_remedy_by_remedy_id_ (
	remedy_id_ timeuuid PRIMARY KEY,
	course_quantity_ int,
	customer_id_ text,
	date_created_ bigint,
	dispense_id_ timeuuid,
	dose_continuous_ text,
	dose_discrete_ text,
	instruction_ text,
	medicine_name_ text,
	oba_ text,
	pharmacy_id_ timeuuid,
	restrictions_ text,
	schedule_ text,
	special_instruction_ text,
	strictness_ int,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 58eb3c40-a5d4-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX deleted_user_id_ ON core_remedy.deleted_remedy_by_remedy_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_remedy.remedy_by_remedy_id_ (
	remedy_id_ timeuuid PRIMARY KEY,
	course_quantity_ int,
	customer_id_ text,
	date_created_ bigint,
	dispense_id_ timeuuid,
	dose_continuous_ text,
	dose_discrete_ text,
	instruction_ text,
	medicine_name_ text,
	oba_ text,
	pharmacy_id_ timeuuid,
	restrictions_ text,
	schedule_ text,
	special_instruction_ text,
	strictness_ int,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 48187131-a5d4-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX user_id_ ON core_remedy.remedy_by_remedy_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS station_label.label_by_dispense_code_ (
	dispense_code_ text PRIMARY KEY,
	date_dispensed_ bigint,
	label_id_ timeuuid,
	pharmacy_id_ timeuuid,
	raw_label_ text,
	station_id_ timeuuid)
	WITH ID = c0b4c450-a5d8-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS station_label.label_by_label_id_ (
	label_id_ timeuuid PRIMARY KEY,
	date_dispensed_ bigint,
	date_in_parser_ bigint,
	dispense_code_ text,
	pharmacy_id_ timeuuid,
	raw_label_ text,
	station_id_ timeuuid)
	WITH ID = ce3aae50-a5d8-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX label_dispense_code ON station_label.label_by_label_id_ (dispense_code_);
---
CREATE INDEX label_pharmacy ON station_label.label_by_label_id_ (pharmacy_id_);
---
CREATE INDEX label_station ON station_label.label_by_label_id_ (station_id_);
---
CREATE TABLE IF NOT EXISTS station_label.code_by_dispense_code_ (
	dispense_code_ text PRIMARY KEY,
	assigned_station_ text,
	date_issued_ bigint,
	locked_station_ text)
	WITH ID = b5877050-a5d8-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX assignedstation ON station_label.code_by_dispense_code_ (assigned_station_);
---
CREATE INDEX lockstation ON station_label.code_by_dispense_code_ (locked_station_);
---
CREATE TABLE IF NOT EXISTS core_bucket.bucket_by_bucket_id_ (
	bucket_id_ timeuuid PRIMARY KEY,
	bucket_ text,
	user_id_ timeuuid)
	WITH ID = 541afe40-a5ce-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_bucket.bucket_by_user_id_ (
	user_id_ timeuuid PRIMARY KEY,
	bucket_ text,
	bucket_id_ timeuuid)
	WITH ID = 6d07c2d0-a5ce-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS station_status.status_by_status_id_ (
	status_id_ timeuuid PRIMARY KEY,
	checkin_stamp_ bigint,
	last_success_ bigint,
	logs_ text,
	next_checkin_ bigint,
	pharmacy_id_ timeuuid,
	station_id_ timeuuid,
	status_flag_ text)
	WITH ID = 87febd00-a5d3-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX status_pharmacy_id ON station_status.status_by_status_id_ (pharmacy_id_);
---
CREATE INDEX status_station_id ON station_status.status_by_status_id_ (station_id_);
---
CREATE TABLE IF NOT EXISTS core_adherence.deleted_adherence_by_adherence_id_ (
	adherence_id_ timeuuid PRIMARY KEY,
	action_ text,
	action_time_ bigint,
	alarm_rang_ bigint,
	alarm_time_ text,
	dose_continuous_ text,
	dose_discrete_ text,
	dose_quantity_ double,
	reasons_ text,
	remedy_id_ timeuuid,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 64511750-a5d2-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX deleted_remedy_id ON core_adherence.deleted_adherence_by_adherence_id_ (remedy_id_);
---
CREATE INDEX deleted_user_id ON core_adherence.deleted_adherence_by_adherence_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_adherence.adherence_by_adherence_id_ (
	adherence_id_ timeuuid PRIMARY KEY,
	action_ text,
	action_time_ bigint,
	alarm_rang_ bigint,
	alarm_time_ text,
	dose_continuous_ text,
	dose_discrete_ text,
	dose_quantity_ double,
	reasons_ text,
	remedy_id_ timeuuid,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 73efcf30-a5d2-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX remedy_id ON core_adherence.adherence_by_adherence_id_ (remedy_id_);
---
CREATE INDEX user_id ON core_adherence.adherence_by_adherence_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_dispense.dispense_by_dispense_id_ (
	dispense_id_ timeuuid PRIMARY KEY,
	course_quantity_ int,
	customer_id_ text,
	date_dispensed_ bigint,
	dispense_code_ text,
	dose_continuous_ text,
	dose_discrete_ text,
	group_id_ timeuuid,
	instruction_ text,
	medicine_name_ text,
	oba_ text,
	parser_confidence_ int,
	pharmacy_id_ timeuuid,
	restrictions_ text,
	scanned_ boolean,
	schedule_ text,
	special_instruction_ text,
	strictness_ int)
	WITH ID = b9092590-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX dispense_code_ ON core_dispense.dispense_by_dispense_id_ (dispense_code_);
---
CREATE TABLE IF NOT EXISTS parser_label.code_by_parsed_label_id_ (
	parsed_label_id_ timeuuid PRIMARY KEY,
	course_quantity_ int,
	customer_id_ text,
	date_dispensed_ bigint,
	date_in_parser_ bigint,
	dispense_code_ text,
	dispense_id_ timeuuid,
	dose_continuous_ text,
	dose_discrete_ text,
	instruction_ text,
	label_id_ timeuuid,
	medicine_name_ text,
	oba_ text,
	parser_confidence_ int,
	pharmacy_id_ timeuuid,
	raw_label_ text,
	restrictions_ text,
	scanned_ boolean,
	schedule_ text,
	special_instruction_ text,
	split_label_ text,
	strictness_ int)
	WITH ID = b536f8a0-a5d3-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX parser_label_id ON parser_label.code_by_parsed_label_id_ (label_id_);
---
CREATE TABLE IF NOT EXISTS parser_status.code_by_parsed_label_id_ (
	parsed_label_id_ timeuuid PRIMARY KEY,
	field_logs_ text,
	field_status_ text,
	label_id_ timeuuid,
	label_status_ text,
	schedule_logs_ text,
	schedule_status_ text,
	splitter_logs_ text,
	splitter_status_ text)
	WITH ID = e70dce60-a5ee-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX status_label_status ON parser_status.code_by_parsed_label_id_ (label_status_);
---
CREATE TABLE IF NOT EXISTS core_user.user_by_id (
	user_id_ timeuuid PRIMARY KEY,
	confirmed_ text,
	date_created_ int,
	hide_ boolean,
	lang_ text,
	user_name_ text,
	user_password_ text)
	WITH ID = 22b62130-a5d4-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX user_by_user_name ON core_user.user_by_id (user_name_);
---
CREATE TABLE IF NOT EXISTS core_appointment.appointment_by_appointment_id_ (
	appointment_id_ timeuuid PRIMARY KEY,
	appointment_time_end_ bigint,
	appointment_time_start_ bigint,
	group_id_ timeuuid,
	pharmacy_id_ timeuuid,
	service_id_ timeuuid,
	state_ text,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = d3ec13a0-a5d5-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX appointment_state ON core_appointment.appointment_by_appointment_id_ (state_);
---
CREATE INDEX pha_id_appt ON core_appointment.appointment_by_appointment_id_ (pharmacy_id_);
---
CREATE INDEX ser_id_appt ON core_appointment.appointment_by_appointment_id_ (service_id_);
---
CREATE INDEX use_id_appt ON core_appointment.appointment_by_appointment_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_group.group_by_group_id_ (
	group_id_ timeuuid PRIMARY KEY,
	group_description_ text,
	group_name_ text,
	user_id_ timeuuid)
	WITH ID = 1b0dc020-a5d2-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_pharmacy.pharmacy_by_group_id_ (
	group_id_ timeuuid PRIMARY KEY,
	address_ text,
	coord_lat_ text,
	coord_long_ text,
	disallowed_message_ text,
	pharmacy_contact_ text,
	pharmacy_email_ text,
	pharmacy_icon_ text,
	pharmacy_id_ timeuuid,
	pharmacy_name_ text,
	pharmacy_timezone_ text,
	pharmacy_unique_ text,
	postcode_ text,
	telephone_ text)
	WITH ID = e118b6e0-a5d1-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_pharmacy.pharmacy_by_pharmacy_id_ (
	pharmacy_id_ timeuuid PRIMARY KEY,
	address_ text,
	coord_lat_ text,
	coord_long_ text,
	disallowed_message_ text,
	group_id_ timeuuid,
	pharmacy_contact_ text,
	pharmacy_email_ text,
	pharmacy_icon_ text,
	pharmacy_name_ text,
	pharmacy_timezone_ text,
	pharmacy_unique_ text,
	postcode_ text,
	telephone_ text)
	WITH ID = efd3ec90-a5d1-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_taker.taker_by_taker_pharmacy_id_ (
	taker_pharmacy_id_ timeuuid PRIMARY KEY,
	customer_id_ text,
	pharmacy_id_ timeuuid,
	taker_id_ timeuuid,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 87c48970-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX pharamcy_taker ON core_taker.taker_by_taker_pharmacy_id_ (pharmacy_id_);
---
CREATE INDEX taker_taker ON core_taker.taker_by_taker_pharmacy_id_ (taker_id_);
---
CREATE INDEX user_taker ON core_taker.taker_by_taker_pharmacy_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_taker.taker_by_taker_id_ (
	taker_id_ timeuuid PRIMARY KEY,
	customer_id_ text,
	luc_ text,
	pharmacy_id_ timeuuid,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 8e262490-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX user_id_taker ON core_taker.taker_by_taker_id_ (user_id_);
---
CREATE TABLE IF NOT EXISTS core_service.service_by_service_id_ (
	service_id_ timeuuid PRIMARY KEY,
	availability_template_ text,
	call_only_ boolean,
	group_id_ timeuuid,
	pharmacy_id_ timeuuid,
	service_description_ text,
	service_enabled_ boolean,
	service_icon_ text,
	service_name_ text,
	service_price_ double,
	service_quantity_ int,
	time_end_ bigint,
	time_start_ bigint)
	WITH ID = db5bf1d0-a5d2-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX service_pharmacy ON core_service.service_by_service_id_ (pharmacy_id_);
---
CREATE TABLE IF NOT EXISTS core_service.deleted_service_by_service_id_ (
	service_id_ timeuuid PRIMARY KEY,
	availability_template_ text,
	call_only_ boolean,
	group_id_ timeuuid,
	pharmacy_id_ timeuuid,
	service_description_ text,
	service_enabled_ boolean,
	service_icon_ text,
	service_name_ text,
	service_price_ double,
	service_quantity_ int,
	time_end_ bigint,
	time_start_ bigint)
	WITH ID = d3bd42d0-a5d2-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_message.message_by_message_id_ (
	message_id_ timeuuid PRIMARY KEY,
	author_ timeuuid,
	group_from_ timeuuid,
	group_to_ timeuuid,
	group_uuids_ text,
	message_body_ text,
	message_date_ bigint,
	message_state_ text,
	subject_ text,
	thread_id_ timeuuid)
	WITH ID = 9b959c00-a5d1-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX author_ ON core_message.message_by_message_id_ (author_);
---
CREATE INDEX thread_id ON core_message.message_by_message_id_ (thread_id_);
---
CREATE TABLE IF NOT EXISTS core_token.device_token_by_device_token_id_ (
	device_token_id_ timeuuid PRIMARY KEY,
	device_token_ text,
	exp bigint,
	group_id_ timeuuid,
	token_id_ timeuuid)
	WITH ID = f565a2a0-a5d3-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX group_id_device_token ON core_token.device_token_by_device_token_id_ (group_id_);
---
CREATE TABLE IF NOT EXISTS excelsior.passwordreset (
	luc_ text PRIMARY KEY,
	user_id_ timeuuid)
	WITH ID = 36053071-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS excelsior.permissions (
	userid timeuuid PRIMARY KEY,
	permissions text)
	WITH ID = 48833a80-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS excelsior.tokentable (
	tokenid timeuuid PRIMARY KEY,
	device_id_ text,
	exp bigint,
	iat bigint,
	payload text,
	userid timeuuid)
	WITH ID = 17ab69f0-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX token_exp ON excelsior.tokentable (exp);
---
CREATE INDEX token_user ON excelsior.tokentable (userid);
---
CREATE TABLE IF NOT EXISTS excelsior.license_ (
	license_ text PRIMARY KEY,
	pharmacy_id_ timeuuid,
	used_ bigint)
	WITH ID = 3fad1cf1-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS excelsior.groupmemberstable (
	groupmemberid timeuuid PRIMARY KEY,
	groupid timeuuid,
	userid timeuuid)
	WITH ID = 4db70400-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX groupindex ON excelsior.groupmemberstable (groupid);
---
CREATE INDEX groupuserindex ON excelsior.groupmemberstable (userid);
---
CREATE TABLE IF NOT EXISTS excelsior.groups (
	groupid timeuuid PRIMARY KEY,
	group_description_ text,
	groupname text,
	grouptype int)
	WITH ID = 44770110-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS excelsior.blacktokentable (
	tokenid timeuuid PRIMARY KEY,
	device_id_ text,
	exp bigint,
	iat bigint,
	payload text,
	userid timeuuid)
	WITH ID = 05b8aff0-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX bl_token_user ON excelsior.blacktokentable (userid);
---
CREATE TABLE IF NOT EXISTS excelsior.devicetokentable (
	token_device_id_ timeuuid PRIMARY KEY,
	device_id_ text,
	group_id_ timeuuid,
	user_id_ timeuuid)
	WITH ID = 0efa1270-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX groupdevice ON excelsior.devicetokentable (group_id_);
---
CREATE INDEX userdevice ON excelsior.devicetokentable (user_id_);
---
CREATE TABLE IF NOT EXISTS excelsior.luc (
	luc_ text PRIMARY KEY,
	taker_id_ timeuuid,
	taker_num_ int,
	user_id_ timeuuid)
	WITH ID = 3a169a00-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS excelsior.usertable (
	userid timeuuid PRIMARY KEY,
	confirmed boolean,
	datecreated_ int,
	forename text,
	hide boolean,
	lang text,
	surname text,
	username text,
	userpassword text)
	WITH ID = 2bc4d480-a690-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX isconirmed ON excelsior.usertable (confirmed);
---
CREATE INDEX username ON excelsior.usertable (username);
---
CREATE TABLE IF NOT EXISTS station_station.station_by_station_id_ (
	station_id_ timeuuid PRIMARY KEY,
	client_version_ text,
	last_dispense_ bigint,
	license_code_ text,
	pharmacy_id_ timeuuid,
	pmr_ text,
	station_type_ text)
	WITH ID = 58b67c60-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX station_pharmacy_id ON station_station.station_by_station_id_ (pharmacy_id_);
---
CREATE INDEX station_station_type ON station_station.station_by_station_id_ (station_type_);
---
CREATE TABLE IF NOT EXISTS station_station.license_by_license_code_ (
	license_code_ text PRIMARY KEY,
	date_used_ bigint,
	pharmacy_id_ timeuuid,
	station_id_ timeuuid)
	WITH ID = 5fbb8370-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE TABLE IF NOT EXISTS core_thread.thread_by_thread_id_ (
	thread_id_ timeuuid PRIMARY KEY,
	author_ timeuuid,
	group_id_ timeuuid,
	group_thread_id_ timeuuid,
	group_uuids_ text,
	initial_from_ timeuuid,
	initial_to_ timeuuid,
	pin_state_ boolean,
	subject_ text,
	thread_date_ bigint,
	thread_type_ text,
	thread_type_id_ timeuuid,
	thread_updated_ bigint,
	unread_from_ bigint,
	unread_to_ bigint)
	WITH ID = 0e49c060-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX author ON core_thread.thread_by_thread_id_ (author_);
---
CREATE INDEX initial_from ON core_thread.thread_by_thread_id_ (initial_from_);
---
CREATE INDEX initial_to ON core_thread.thread_by_thread_id_ (initial_to_);
---
CREATE INDEX thread_type_id ON core_thread.thread_by_thread_id_ (thread_type_id_);
---
CREATE TABLE IF NOT EXISTS core_thread.thread_by_group_thread_id_ (
	group_thread_id_ timeuuid PRIMARY KEY,
	author_ timeuuid,
	group_id_ timeuuid,
	initial_from_ timeuuid,
	initial_to_ timeuuid,
	pin_state_ boolean,
	subject_ text,
	thread_date_ bigint,
	thread_id_ timeuuid,
	thread_type_ text,
	thread_type_id_ timeuuid,
	thread_updated_ bigint,
	unread_from_ bigint,
	unread_to_ bigint)
	WITH ID = 16ca43e0-a5ef-11e6-8a70-23f0d712ef02
	AND bloom_filter_fp_chance = 0.01
	AND dclocal_read_repair_chance = 0.1
	AND crc_check_chance = 1.0
	AND default_time_to_live = 0
	AND gc_grace_seconds = 864000
	AND min_index_interval = 128
	AND max_index_interval = 2048
	AND memtable_flush_period_in_ms = 0
	AND read_repair_chance = 0.0
	AND speculative_retry = '99PERCENTILE'
	AND comment = ''
	AND caching = { 'keys': 'ALL', 'rows_per_partition': 'NONE' }
	AND compaction = { 'max_threshold': '32', 'min_threshold': '4', 'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy' }
	AND compression = { 'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor' }
	AND extensions = {  };
---
CREATE INDEX group_id ON core_thread.thread_by_group_thread_id_ (group_id_);
---
CREATE INDEX thread_id_group ON core_thread.thread_by_group_thread_id_ (thread_id_);
