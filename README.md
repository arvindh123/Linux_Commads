
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


## RIOT-OS  Running in WSL 
Install addition things to run 32 bit .elf file in 64 bit WSL, If the WSL is old and if you can't able to update to WSL2
-  ``` sudo apt update ```
-  ``` sudo apt install qemu-user-static ```
-  ``` sudo update-binfmts --install i386 /usr/bin/qemu-i386-static  --magic '\x7fELF\x01\x01\x01\x03\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x03\x00\x01\x00\x00\x00' --mask  '\xff\xff\xff\xff\xff\xff\xff\xfc\xff\xff\xff\xff\xff\xff\xff\xff\xf8\xff\xff\xff\xff\xff\xff\xff' ```

## WSL 1 Debain package debuild
```sudo update-alternatives --set fakeroot /usr/bin/fakeroot-tcp```

## To get 1st Pid Command , to find the SystemV or Systemd or Upstart
``` ps -p 1 -o comm= ```
## To put the logger to another file 
##### At peresent it make no sense, we can directly use tee
``` logger --no-act  -s "Some Message to Logger" 2>&1  |  tee -a test.log ```

## Docker Stat Single container to Log File 
### Linux 
```
SET CONTAINER_NAME="Test_Container_Name"
```
```
docker stats --format "{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.MemPerc}}\t{{.PIDs}}" $CONTAINER_NAME | ts | tee -a $CONTAINER_NAME.log
```
### Windows Powershell
```
 Set-Variable -Name "CONTAINER_NAME" -Value "Test_Container_Name"
```
```
docker stats --format "{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.MemPerc}}\t{{.PIDs}}" $CONTAINER_NAME |  %{ "{0:HH:mm:ss:fff}: {1}" -f (Get-Date), $_ } | tee -FilePath "$($CONTAINER_NAME).log" -Append
```
