# Timescaledb v1.7.1
# Step -1 
Install the timescaledb repo
```
curl -s https://packagecloud.io/install/repositories/timescale/timescaledb/script.deb.sh | sudo bash
```

# Step - 2
Change in the /etc/apt/sources.list.d/timescale_timescaledb.list 
```
deb https://packagecloud.io/timescale/timescaledb/raspbian/ buster main 
deb-src https://packagecloud.io/timescale/timescaledb/raspbian/ buster main
```  
**to**
```
deb https://packagecloud.io/timescale/timescaledb/debian/ buster main 
deb-src https://packagecloud.io/timescale/timescaledb/debian/ buster main
```

# Step - 3
Update the apt repos
```
sudo apt-get update
```

# Step - 4
Install timescaledb with postgres
```
sudo apt-get install timescaledb-1.7.1-postgresql-11=1.7.1~debian10
```

# Step - 5
```
echo "shared_preload_libraries = 'timescaledb'" >>   /etc/postgresql/11/main/postgresql.conf
```

# Step - 6
```
sudo systemctl restart postgresql.service
```

# Step - 7
```
sudo systemctl restart postgresql@11-main.service
```

# Step - 8
```
sudo su postgres
```

# Step - 9
```
psql
```

# Step - 10
```
\c postgres
```

# Step - 11
 ```
 CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
 ```
 
# Step - 12
```
CREATE TABLE daq.data (                                                               
 "time" timestamptz NOT NULL,
 machineref int4 NOT NULL,
 "key" varchar NOT NULL,
 value varchar NOT NULL
);
```
 
# Step - 13
```
SELECT create_hypertable('daq.data', 'time',chunk_time_interval => INTERVAL '1 day' );
```
# Step - 14
```
CREATE INDEX ON daq.data (time DESC, machineref);
```

# Step - 15
```
SELECT add_drop_chunks_policy('daq.data', INTERVAL '336 hours');
```
