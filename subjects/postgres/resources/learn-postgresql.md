# Learn PostgreSQL
<img src="../../../covers/9781838985288.jpg" width="200"/>

## Chapter 1/20 <sup>(published)</sup>

<details>
<summary>What is the meaning of ACID terminology?</summary>

> **Description**
>
> - **Atomicity**: Complex database operations is proccessed as a single
>   instruction.
> - **Consistency**: Data within the database will not be corrupted due to
>   partially performed operations.
> - **Isolation**: Allows database to handle concurrency, without interleaved
>   changes.
> - **Durability**: Database engine is supposed to protect the data it
>   contains, even in the case of software and hardware failures.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How does PostgreSQL store data on storage?</summary>

> **Description**
>
> PostgreSQL stores its data on storage system in binary format and this format
> could possibly change between major versions.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How long is the life time of a PostgreSQL release?</summary>

> **Description**
>
> PostgreSQL provides support and upgrades for 5 years after a new release is
> issued; after this length of time, a major release will reach its end of life
> (EOL) and PostgreSQL developers will no longer maintain it.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What is a PostgreSQL cluster?</summary>

> **Description**
>
> A PostgreSQL instance is called a cluster because a single instance can serve
> and handle multiple databases.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What is a schema?</summary>

> **Description**
>
> A database can be organized into namespaces, called schemas. Schemas cannot
> be nested, so they represent a flat namespace.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What are the building blocks of an instance?</summary>

> **Description**
>
> Database objects are represented by everything the user can create and manage
> within the database; for instance, tables, functions, triggers, and data
> types.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What schema an object in postgres belongs to?</summary>

> **Description**
>
> Every object belongs to one and only one schema that, if not specified, is
> the default public schema.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What schema do users belong to?</summary>

> **Description**
>
> Users are defined at a cluster-wide level, which means they are not tied to a
> particular database in the cluster.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How many user categories exist in postgres?</summary>

> **Description**
>
> PostgreSQL has two user categories: normal users who can connect to and
> handle databases and objects, and superusers who can do anything with any
> database object.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How many superusers are allowed in a postgres instance?</summary>

> **Description**
>
> PostgreSQL allows the configuration of as many superusers as you need, and
> every superuser has the very same permissions.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>Where are the internal postgres instance data stored?</summary>

> **Description**
>
> PostgreSQL internal data, such as users, databases, namespaces,
> configuration, and database runtime status, is provided by means of catalogs,
> which are special tables that present information in a SQL-interactive way.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>Where does postgres store its data?</summary>

> **Description**
>
> PostgreSQL stores all of its content in a single filesystem directory known
> as `PGDATA`.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What is <code>PGDATA</code> contained of?</summary>

> **Description**
>
> The `PGDATA` directory represents what the cluster is serving as databases, and
> it consists of at least the write-ahead logs (WALs) and the data storage.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How is it possible to have multiple postgres installations?</summary>

> **Description**
>
> It is possible to have a single installation of PostgreSQL and make it switch
> to different `PGDATA` directories to deliver different content.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>When does postgres need the <code>PGDATA</code> directory?</summary>

> **Description**
>
> The `PGDATA` directory needs to be initialized by creation of the directory
> structure within it before it can be used by PostgreSQL.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What is the purpose of postgres's first process?</summary>

> **Description**
>
> The first single process of PostgreSQL is **postmaster** which waits for incoming
> client connections.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How does postgres handles connections?</summary>

> **Description**
>
> The postmaster process forks backend processes which each of them serve one
> and only one connection.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>Build postgres from source?</summary>

> **Description**
>
> First build the project:
>
> ```sh
> git clone https://github.com/postgresql/postgresql
> cd postgresql
> git checkout <latest>
> ./configure --prefix=$HOME/.local
> make
> make install
> ``````
>
> Create postgres user and initialize database:
>
> ```sh
> sudo useradd postgres
> sudo mkdir /opt/postgres
> sudo chown postgres:postgres /opt/postgres
> initdb -D /opt/postgresql
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>How to add systemd support to postgres installation?</summary>

> **Description**
>
> ```sh
> ./configure --prefix=$HOME/.local --with-systemd
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1
> ---
> **References**
> ---
</details>

<details>
<summary>Build postgres using pgenv?</summary>

> **Description**
>
> ```sh
> git clone https://github.com/theory/pgenv
> cp pgenv/bin/pgenv ~/.local/bin/
> pgenv available
> pgenv build <version>
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>Connect to a postgres instance?</summary>

> **Description**
>
> ```sh
> psql -U postgres -h localhost template1
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1/20
> ---
</details>

<details>
<summary>What libraries are required for C++ projects to link to postgres?</summary>

> **Description**
>
> ```cmake
> target_link_libraries(executable PRIVATE pq pqxx)
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 1
> ---
> **References**
> ---
</details>

## Chapter 2/20 <sup>(writing)</sup>

<details>
<summary>What tool is used to manage postgres cluster?</summary>

> **Description**
>
> `pg_ctl` command-line utility is shipped with postgres that helps in managing
> the clusters.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the basic functionalities of <code>pg_ctl</code>?</summary>

> **Description**
>
> * `start`, `stop`, and `restart` execute the corresponding actions.
> * `status` reports current status of cluster.
> * `reload` reloads the configuration.
> * `initdb` or briefly `init` executes the initialization of the cluster.
> * `promote` is used when the cluster is running as a subordinate.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What process is started with <code>pg_ctl</code> on postgres bring up?</summary>

> **Description**
>
> `postmaster` process is started by `pg_ctl start` and it shows
> `$PGENV_ROOT/bin/postgres` as the executable running.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How many stopping modes are possible for postgres?</summary>

> **Description**
>
> * `smart`: waits for connected clients to disconnect first
> * `fast`: immediately disconnects clients but cleans up before exit
> * `immediate`: aborts every postgres process and exists
>
> ```sh
> $PGENV_ROOT/bin/postgres stop -m smart
> ``````
>
> By default `fast` stop mode is the default.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What user does postgres needs to operate?</summary>

> **Description**
>
> Postgres must be run by an unprivileged user.
> Postgres is run by a normal user usually named `postgres`.
>
> ```sh
> sudo -E -u postgres pg_ctl stop
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How does postgres know when the storage is?</summary>

> **Description**
>
> That almost every Postgres-related command searches for the value of PGDATA
> as an environmental variable or as a `-D` command-line option.
>
> ```sh
> export PGDATA=/opt
> pg_ctl status -D /usr/local
> ``````
>
> Option `-D` precedes using environment variables.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What are the names of template databases?</summary>

> **Description**
>
> `template0` and `template1` are first databases. `template0` is a safe copy
> for rebuilding in case `template1` is accidentally damaged or removed.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Connect to an instance using psql?</summary>

> **Description**
>
> You can either use command options or use a connection string to address a
> cluster.
>
> ```sh
> psql -U <username> -h <hostname> -d <database>
> psql postgresql://username@hostname:5432/database
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What command is used to quit the interactive terminal?</summary>

> **Description**
>
> ```psql
> \q
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>List all available databases in an instance?</summary>

> **Description**
>
> ```sh
> psql -l
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What tool can be used to create a postgres cluster?</summary>

> **Description**
>
> When you connect to an instance, you connect to one of the nodes in the
> cluster.
>
> ```sh
> ${PGENV_ROOT}/bin/initdb
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Enable authentication on local connections?</summary>

> **Description**
>
> Trust is enabled on local connections by default. You can change this by
> editing `pg_hba.conf` or using the option `-A`, or `--auth-local` and
> `--auth-host`, the next time you run initdb.
>
> ```psql
> ${PGENV_ROOT}/bin/initdb --auth-local --auth-host
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>How does initdb create a cluster?</summary>

> **Description**
>
> Postgres builds the filesystem layout of `PGDATA` directory and builds two
> template databases `template0` and `template1`.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>Enter a SQL statement via psql?</summary>

> **Description**
>
> ```sh
> su -u postgres psql -d template1 -h postgres
> ``````
>
> ```psql
> select current_time;
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What is the secondary statement terminator in psql?</summary>

> **Description**
>
> ```psql
> select current_time \g
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What command opens an editor to edit psql query buffer?</summary>

> **Description**
>
> ```psql
> \e
> ``````
>
> Opens the editor specified in `EDITOR` environment variable.
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What psql command executes sql statements from a file?</summary>

> **Description**
>
> ```psql
> \i <file>
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What command gives help information about psql?</summary>

> **Description**
>
> ```psql
> \h select
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

<details>
<summary>What command gives help with the psql commands?</summary>

> **Description**
>
> ```psql
> \?
> ``````
>
> ---
> **Resources**
> - Learn PostgreSQL - Chapter 2
> ---
> **References**
> ---
</details>

## Chapter 3/20
## Chapter 4/20
## Chapter 5/20
## Chapter 6/20
## Chapter 7/20
## Chapter 8/20
## Chapter 9/20
## Chapter 10/20
## Chapter 11/20
## Chapter 12/20
## Chapter 13/20
## Chapter 14/20
## Chapter 15/20
## Chapter 16/20
## Chapter 17/20
## Chapter 18/20
## Chapter 19/20
## Chapter 20/20
