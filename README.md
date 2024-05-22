# Data Lineage

<img src="./images/Data Lineage.png" alt="Getting started" />

<br />



## Prepare infrastructure
```bash
make build infrastructure
```

### Prepare MySQL data
```sql
# copy CSV data to mysql container
# cd path/to/leagues_scorers/
docker cp ./transfermarkt/data/ de_mysql:/tmp/
docker cp ./mysql_schemas.sql de_mysql:/tmp/

# login to mysql server as root
docker exec -it [YourContainerId] bin/bash

# Once we are logged in, we can now login to mysql as root .
mysql --local-infile=1 -u root -p

CREATE DATABASE leagues_scorers;
USE leagues_scorers;
GRANT ALL PRIVILEGES ON *.* TO admin;


# We check status of LOCAL_INFILE
# LOAD DATA LOCAL INFILE is not enabled by default in MySQL, 
SHOW GLOBAL VARIABLES LIKE 'LOCAL_INFILE';


# If was started with --local-infile=0, LOCAL does not work. Then should be enabled it
SET GLOBAL LOCAL_INFILE=TRUE;


source /tmp/mysql_schemas.sql;
show tables;

LOAD DATA LOCAL INFILE '/tmp/data/competitions.csv' INTO TABLE competitions 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/games.csv' INTO TABLE games 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/clubs.csv' INTO TABLE clubs
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/club_games.csv' INTO TABLE club_games 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/players.csv' INTO TABLE players
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/appearances.csv' INTO TABLE appearances 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/player_valuations.csv' INTO TABLE player_valuations 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/tmp/data/game_events.csv' INTO TABLE game_events 
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


SELECT * FROM competitions LIMIT 5;
SELECT * FROM games LIMIT 5;
SELECT * FROM clubs LIMIT 5;
SELECT * FROM club_games LIMIT 5;
SELECT * FROM players LIMIT 5;
SELECT * FROM appearances LIMIT 5;
SELECT * FROM player_valuations LIMIT 5;
SELECT * FROM game_events LIMIT 5;
```

### Prepare Medallion Architecture
```bash
trino> CREATE SCHEMA IF NOT EXISTS datalake.bronze WITH (location = 's3a://warehouse/bronze');
CREATE SCHEMA
trino> CREATE SCHEMA IF NOT EXISTS datalake.silver WITH (location = 's3a://warehouse/silver');
CREATE SCHEMA
trino> CREATE SCHEMA IF NOT EXISTS datalake.gold WITH (location = 's3a://warehouse/gold');
```

### Prepare dbt-trino
```bash
    dbt init --profiles-dir ./ transfermarkt_analytics
    ## Choose connector is trino
    []: trino
```
```
    And now setup 3 folder following bronze, silver and gold bucket
```

# Transform MySQL data To DataLake (Minio)
```bash
    make build data-lake
```

# Build Data Warehouse (GCP)
```bash
    make build data-warehouse
```

# Build Data Lakehouse (Dremio)
```bash
    make build data-lakehouse
```
