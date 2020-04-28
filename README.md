
## To kill the process with some name
  ```
  FindProcess = "python3"
  ps aux | grep $FindProcess | awk '{ print $2; system("kill -9 " $2)  }'
  ``` 
  
## SQL Query 

```
DO $$ 
DECLARE 
	tableName VARCHAR(255) := '';
	fileName VARCHAR(255) := '';
	edgeTotal INT := 600;
	devTotal INT := 100;
BEGIN
	FOR edge IN 1..edgeTotal LOOP
		FOR dev IN 1..devTotal LOOP
			RAISE NOTICE 'Working on Dev - % 	Edge-%',edge,dev;
			tableName = CONCAT('schema-eid_',edge,'-dev_',dev);
			fileName = CONCAT('/var/lib/postgresql/data/export/sgipl_chennai-eid_',edge,'-dev_',dev,'.csv');
 			EXECUTE  'COPY (SELECT * from schema.table where metrics_id = '''|| tableName ||''' ) TO ''' || fileName || ''' DELIMITER '','' CSV HEADER';
 			RAISE NOTICE 'Completed on Dev - % 	Edge-%',edge,dev;
		END LOOP;
	END LOOP;
END $$;

```
