# PostgreSQL
# Learn PostgreSQL
## book
## Packt Publishing
### chapter
### Luca Ferrari
#### surface

#### Backup Strategies
##### Backup and Restore

###### What are the differences between logical backup and physical backup?

A logical backup works similarly to a database client that asks for all the data in a database, table by table, and stores the result in a storage system.

###### What permissions are required for the user to perform a database backup?

PostgreSQL does not require a special backup permission to dump the content of a database> But, in order to restore data, the user must obtain sufficient permission to write data into tables. There are two predefined roles, `pg_read_all_data` and `pg_write_all_data`, that can be granted to the user who performs restore.

#### Logical Backup
##### Backup and Restore

###### What are the advantages of using logical backup?

* Performing a logical backup is simple
* It is consistent
* It can be restored easily
* This method works between database versions

###### What are the disadvantages of using logical backup?

* It slows down other active concurrent transactions
* It requires the database to keep track of the ongoing backup process without corrupting the snapshot as long as the backup is running
* The produced backup set is consistent at the time the backup has started and data changes that occurred in the meantime might not be present in the backup

###### What logical backup formats are available in PostgreSQL?

* plain text: backup file contains SQL statements
* directory format: backup is placed into a directory, and database objects are placed into a compressed file
* tar format: archived version of directory format
* custom format: PostgreSQL specific format suitable for selective restore via `pg_restore` utility

#### Physical Backup
##### Backup and Restore

###### What are the advantages of physical backup?

* Physical backup requires a file-level copy of `PGDATA`, therefore it is invasive with regard to other connections and transactions
* the restore will proceed as if the database has crashed and will redo all the transactions in order to achieve a consistent state
* It allows for point-in-time recovery (PITR), which allows a database administrator to recover the database to any instance since the original backup

###### What are the disadvantages of physical backup?

* This kind of backup is much more complex to set up
* On the other hand, physical backups will only work between the very same major versions of PostgreSQL instances and operating system architecture

#### Text Backup
##### Backup and Restore

###### Perform a logical backup on a local cluster?

```sh
pg_dump <database> 
```

###### Perform a logical backup and write the results into a file?

```sh
pg_dump <database> -f <file>.sql
pg_dump <database> --file <file>.sql
```

###### Perform a backup with verbose output?

```sh
pg_dump <database> -v
pg_dump <database> --verbose
```

###### Perform a logical backup remotely on a cluster?

Both `pg_dump` and `pg_dumpall` commands can work locally and remotely on the cluster.

```sh
pg_dump -h <host> <database>
pg_dump --host <host> <database>
```

###### What is the side effect of removed search path in the backup?

After restoration, the user will not be able to find any not fully qualified objects by their names.

###### In what scenarios would you want to use insert instead of copy statements in the backup?

`pg_dump` defaults to using `COPY` to bulk load data into single tables. However, this may not compatible between across different database engines. So if your aim is to dump database content to migrate it to another engine, you should use insert backup instead:

```sh
pg_dump --inserts <database>
```

But, the list of columns every field value maps to is still missing with this option. To make backup fully compatible:

```sh
pg_dump --column-inserts <database>
```

###### Perform a logical backup including database creation statement?

```sh
pg_dump -C --column-inserts -f <database>.sql <database>
pg_dump --create --column-inserts --file <database>.sql <database>
```

###### Perform a logical backup including only schema?

In case you already have the database schema in place, and you only need the database content:

```sh
pg_dump -s -f <database>.sql <database>
pg_dump --schema-only --file <database>.sql <database>
```

###### Perform a logical backup excluding schema?

```sh
pg_dump -a -f <database>.sql <database>
pg_dump --data-only --file <database>.sql <database>
```

###### Perform a logical backup limited to the scope of a table?

```sh
pg_dump -t <database>.<table> -f <database>.sql <database>
pg_dump --table <database>.<table> --file <database>.sql <database>
```

###### Perform a logical backup excluding a table?

```sh
pg_dump -T <database>.<table> -f <database>.sql <database>
pg_dump --exclude-table <database>.<table> --file <database>.sql <database>
```

###### Perform a logical backup stored in a compressed archive?

Compression option accepts an integer from 0 to 9 indicating compression level.

```sh
pg_dump -f <database>.sql.gz -Z <0-9> <database>
pg_dump --file <database>.sql.gz --compress <0-9> <database>
```

#### Restore Text Backup
##### Backup and Restore

###### Restore a plain text backup?

```sh
pg_dump --column-inserts -f <database>.sql <database>
```

By default, `pg_dump` does not issue database creation statement. This is intentional but can be dangerous if you mistakenly import the backup into an incorrect database.

```sh
psql -U postgres -c "drop database if exists <database>"
psql --username postgres --command "drop database if exists <database>"
```

```sh
psql -U postgres -c "create database <database> with owner <owner>"
```

```sh
psql -U <owner> -f <database>.sql <database>
```

#### Configure Search Path
##### Backup and Restore

###### Configure a database to look up for tables within a search path?

```postgres
select pg_catalog.set_config('search_path', 'public', '"$user"', false);
```

#### Formatted Backup
##### Backup and Restore

###### Perform a formated logical backup?

Plain text is the default format and can be omitted:

```sh
pg_dump -F p -f <database>.sql <database>
pg_dump --format p --file <database>.sql <database>
```

Custom format:

```sh
pg_dump -F c -C -f <database>.bak <database>
pg_dump --format c --create --file <database>.bak <database>
```

Directory format:

```sh
pg_dump -F d -f <directory> <database>
pg_dump --format d --file <directory> <database>
```

Tar format:

```sh
pg_dump -F t -f <database>.tar <database>
pg_dump --format t --file <database>.tar <database>
```

###### Perform a faster backup with parallel processes?

`pg_dump` will open parallel connections to the database in number equal to the parallelism, plus
one connection to rule them all, and will force every connection to dump a separate table.

```sh
pg_dump -F d -j 2 -f <database>.sql -v <database>
pg_dump --format d --parallel 2 --file <database>.sql --verbose <database>
```

Since all the processes will dump a single table, parallel mode is only available for the directory format, where every table is stored in a separate file so that processes don’t mix their writes together.

#### Restore Formatted Backup
##### Backup and Restore

###### Print the list of content of the backup?

```sh
pg_restore --list <database>.bak
pg_restore --list <directory>
pg_restore --list <database>.tar
```

###### Restore a database from a formatted backup?

```sh
pg_restore -C -d postgres <database>.bak
pg_restore -C -d postgres <directory>
pg_restore -C -d postgres <database>.tar
```

The `-C` option indicates recreating database before restoring objects into it.
The `-d` option takes the role to connect to and issue a database creation.

###### Restore a database from a formatted backup into a file?

Backup will only be stored in the output file and will not be executed on the database.

```sh
pg_restore -f <database>.sql <database>.bak
```

###### Perform a backup using list of content?

If you move or delete lines from the ToC, you can instruct pg_restore to change its execution:

```sh
pg_restore -C -d postgres -L <toc>.txt <database>.bak
pg_restore -C -d postgres -L <toc>.txt <directory>
pg_restore -C -d postgres -L <toc>.txt <database>.tar
```

###### Perform a restoration in parallel?

Unlike `pg_dump`, `pg_restore` can work in parallel for both the directory format and the custom format.

```sh
pg_restore -C d postgres -j 2 -v <database>.bak
pg_restore -C d postgres -j 2 -v <directory>
```

#### Backup Cluster
##### Backup and Restore

###### Perform a backup from the entire cluster?

`pg_dumpall` loops over all the databases available in the cluster and performs a single pg_dump on each, and then it dumps the specific objects that are at a cluster level, such as roles.

```sh
pg_dumpall -f <cluster>.sql
pg_dumpall --file <cluster>.sql
```

#### Scheduling Backup
##### Backup and Restore

###### Schedule backup?

```sh
#!/usr/bin/env bash

backup_root=/srv/postgres/backup

readarray databases < <(psql -U postgres -d postgres -At -c "select datname from pg_database where datname <> 'template0'")

for database in "${databases[@]}"
do
    backup_directory="$backup_root/$database/$(date +%Y-%m-%d)"
    
    if [ ! -d "$backup_directory" ]
    then
        mkdir --parents "$backup_directory"
        if pg_dump -U postgres -d "$database" -F c
        then
            echo "$(date +%Y-%m-%d): $database backup successful"
        else
            echo "$(date +%Y-%m-%d): $database backup failed"
        fi
    fi
done
```

The script can be used by crontab or systemd for scheduling.

```crontab
30 0 * * * backup-cluster.sh
```

#### Copying Data
##### Backup and Restore

###### Export contents of a table into a file?

```postgres
copy <database>.<table> to '/srv/postgres/<database>.<table>.txt';
```

###### Export contents of a table with CSV format into a file?

Output can be customized:

```postgres
copy <database>.<table> to '/srv/postgres/<database>.<table>.txt' with (header on, delimiter ';');
```

But for known formats, we can use `format` option:

```postgres
copy <database>.<table> to '/srv/postgres/<database>.<table>.txt' with (format csv);
```

###### Filter contents of a table when exporting to a file?

```postgres
copy (select * from <database>.<table> where pk % 2 = 1)
to '/srv/postgres/<database>.<table>.txt'
with (format csv);
```

###### Import contents of a table from a file?

```postgres
create table <table>_reloaded (like <table>);
```

```postgres
copy <database>.<table> from '/srv/postgres/<database>.<table>.txt';
```

###### Filter contents of a table when importing from a file?

```postgres
copy <database>.<table>
from '/srv/postgres/<database>.<table>.txt'
where pk % 2 = 1;
```

###### Import contents of a table from a program?

```sh
#!/usr/bin/env bash

for id in {1..10}
do
    echo "$id,$RANDOM"
done
```

```sh
chmod u+x random-generator
```

```postgres
copy <database>.<table>
from program $code$ ./random-generator $code$
with (format csv);
```

###### Export contents of a table into a program?

```postgres
copy <database>.<table>
to program $code$ awk '{print $2}' > /tmp/col2.txt $code$;
```

###### What is the alternative to the copy command for unprivileged users?

Running `copy` requires `pg_write_server` privilege, but unprivileged users can run `\copy` as an alternative:

```postgres
\copy <database>.<table> to '/srv/postgres/<database>.<table>.txt' with (format csv);
```

#### Physical Backup
##### Backup and Restore

###### Card
