-- content          varchar(2000),
-- type             flashback.block_type('text', 'code'),
-- language         varchar(10)

-- resource_name    varchar(1000) ,
-- section_name     varchar(100),
-- heading          varchar(400),
drop table if exists temp_blocks;
create temp table temp_blocks (t_content varchar(2000), t_type flashback.block_type, t_language varchar(10));

insert into temp_blocks values ('`postgres` user is default admin in postgres.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What user is created on postgres by default?');

--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');
--
--insert into temp_blocks values ('', 'text', 'txt');
--call flashback.create_note('Learn PostgreSQL', 'Chapter 3', '');

insert into temp_blocks values ('**Data Definition Language (DDL)** commands are used to manage databases and tables.', 'text', 'txt');
insert into temp_blocks values ('**Data Manipulation Language (DML)** commands are used to insert, delete, update and select data inside databases. ', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What type of commands exist in database?');

insert into temp_blocks values ('psql -U <username> -h <hostname> -d <database>', 'code', 'sh'), ('psql -U postgres -h localhost -d template1', 'code', 'sh');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Connect to a postgres instance?');

insert into temp_blocks values ('\x', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Switch postgres to expanded mode?');

insert into temp_blocks values ('\l', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'List databases present in the cluster?');

insert into temp_blocks values ('\c <database>', 'code', 'sql');
insert into temp_blocks values ('\c postgres', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Connect to a database in psql?');

insert into temp_blocks values ('create database <database>', 'code', 'sql');
insert into temp_blocks values ('create database sample', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Create a new database?');

insert into temp_blocks values ('`template1`', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What database is used to clone as new ones?');

insert into temp_blocks values ('`template0` is a read-only backup in case `template1` is accidentally removed.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Why is there two template databases?');

insert into temp_blocks values ('Databases can be organized by namespaces called schema.', 'text', 'txt');
insert into temp_blocks values ('Schemas cannot be nested, and they represent a flat namespace.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What is a schema?');

insert into temp_blocks values ('A normal user cannot perform DDL on the public schema.', 'text', 'txt');
insert into temp_blocks values ('A normal user cannot perform DML on the public schema unless superuser allows that.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What schema can be used by a normal user?');

insert into temp_blocks values ('Contains the sequence of schemas that postgres uses to find tables.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What is the <code>search_path</code> variable?');

insert into temp_blocks values ('create database sample;
\c sample
create user first_user with password "complex password" login;
create schema sample_uexamples', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Allow a user to create database objects in a custom schema?');

insert into temp_blocks values ('\dt', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'List all available databases?');

insert into temp_blocks values ('create database project template project_defaults;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Create a database from a user defined template?');

insert into temp_blocks values ('drop database projects;', 'code', 'sql');
insert into temp_blocks values ('When there are dependencies to the database, this action can cascade to all of them too.', 'text', 'txt');
insert into temp_blocks values ('drop database projects cascade;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Drop a database?');

insert into temp_blocks values ('drop table users;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Drop a table from a database?');

insert into temp_blocks values ('\l+ project', 'code', 'sql');
insert into temp_blocks values ('select pg_database_size(''project'');', 'code', 'sql');
insert into temp_blocks values ('select pg_size_pretty(pg_database_size(''project''));', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Get the size of a database?');

insert into temp_blocks values ('select * from pg_database where datname = ''project'';', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Find the Object ID of a database on storage?');

insert into temp_blocks values ('create table users ( id int generated always as identity, username varchar(40) not null, primary key(id), unique(username));', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Create a table?');

insert into temp_blocks values ('create table if not exists users;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Create a table only when it doesn''t already exist?');

insert into temp_blocks values ('1. Logged Tables: these are the regular tables we create.', 'text', 'txt');
insert into temp_blocks values ('create table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
insert into temp_blocks values ('2. Unlogged Tables: faster than regular tables but they are not crash-safe..', 'text', 'txt');
insert into temp_blocks values ('create unlogged table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
insert into temp_blocks values ('3. Temporary Tables: mostly used in transactions for isolation and is only visible to the session where it was created.', 'text', 'txt');
insert into temp_blocks values ('create temp table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'How many table types exist?');

insert into temp_blocks values ('First, create a session. Then create the temp table. And finally, commit or roll back the transaction.', 'text', 'txt');
insert into temp_blocks values ('begin work;
create temp table sample (id int generated always as identity, primary key (id)) on commit drop;
commit work;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'How temp tables can be dropped automatically?');

insert into temp_blocks values ('select oid, relanem from pg_class where relname = ''users'';', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Get the object ID of a table on storage?');

insert into temp_blocks values ('It is possible to insert one or more rows specified by value expressions, or zero or more rows resulting from a query.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'How many ways are possible to insert into data a table?');

insert into temp_blocks values ('insert into users (username) values (''user1'');', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Insert data into a table with value expressions?');

insert into temp_blocks values ('select * from users;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Select data from a table out of order?');

insert into temp_blocks values ('select * from users order by joined;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Order the output of a select query?');

insert into temp_blocks values ('insert into users (username) values (''user1''), (''user2'');', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Insert multiple rows into a table in one insertion?');

insert into temp_blocks values ('select * from users where joined between ''2024-08-01'' and ''2026-08-01'';', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'Filter select query results?');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('1. Asending `asc` which is the default when not specified.
2. Desending: `desc`.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'How many ordering directions exist?');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', 'What variations of writing order by clause exist?');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

insert into temp_blocks values ('', 'code', 'sql');
insert into temp_blocks values ('', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 4', '');

--call set_section_as_complete('Learn PostgreSQL', 'Chapter 3');

