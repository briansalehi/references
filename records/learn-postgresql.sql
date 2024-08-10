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

insert into temp_blocks values ('A role can be a single account, or a group representing a collection of database permissions and connection properties.', 'text', 'txt');
insert into temp_blocks values ('Every role must have a unique username.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What is a role?');

insert into temp_blocks values ('A role is defined at the cluster level, while permissions are defined at the database level.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What is the difference between roles and permissions scopes?');

insert into temp_blocks values ('create role <name> with password ''secret'' login;', 'code', 'sql');
insert into temp_blocks values ('The default option is `NOLOGIN`. Therefore, in order to define interactive users, remember to add the `LOGIN` option when creating a role.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Create a new role having privileges to login in to the cluter?');

insert into temp_blocks values ('Almost every option of the `create role` statement has a positive form that adds the ability to the role, and a negative form with `NO` prefix that excludes the ability from the role.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What are the general forms of role creation options?');

insert into temp_blocks values ('create role <user> with password ''secret'' superuser login;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Create a role with superuser privileges?');

insert into temp_blocks values ('create role <user> with password null;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Create a role without a password?');

insert into temp_blocks values ('create role <user> with password ''secret'' login connection limit 1;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Limit the number of connections a role can make to the cluster?');

insert into temp_blocks values ('create role <user> with password ''secret'' login valid until ''2026-12-31'';', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Create a role that will be expired within a year?');

insert into temp_blocks values ('A group is a role that contains other roles.', 'text', 'txt');
insert into temp_blocks values ('To create a group simply create a role without a login capability.', 'text', 'txt');
insert into temp_blocks values ('create role <group> with nologin;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Create a group?');

insert into temp_blocks values ('create role <user> with login password ''secret'' in role <group> connection limit 1 valid until ''2026-12-31'';', 'code', 'sql');
insert into temp_blocks values ('The `in group` clause of `create role` is an absolute synonym for the `in role` clause.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Join a role into a group when creating one?');

insert into temp_blocks values ('grant <group> to <user>;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Join a role into a group after its creation?');

insert into temp_blocks values ('create role <group> with nologin admin <user>;', 'code', 'sql');
insert into temp_blocks values ('The <user>, even if not a cluster superuser, will be able to add new members to the <group>.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Specify an admin for a group when creating one?');

insert into temp_blocks values ('grant <group> to <user> with admin option;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Specify an admin for a group after its creation?');

insert into temp_blocks values ('drop role if exists <user>;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Remove a role?');

insert into temp_blocks values ('select current_role;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Inspect current role?');

insert into temp_blocks values ('\du', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Get a list of all available roles in the cluster?');

insert into temp_blocks values ('\drg', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'List the groups a role is a member of?');

insert into temp_blocks values ('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_roles where rolname = ''user'';', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Get a user information from roles catalog?');

insert into temp_blocks values ('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_authid where rolname = ''user'';', 'code', 'sql');
insert into temp_blocks values ('The catalog `pg_roles` can be queried by either superuser or normal users, but `pg_authid` can only be queried by superuser.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Get sensitive information of roles in the cluster?');

insert into temp_blocks values ('`$PGDATA/pg_hba.conf`', 'text', 'txt');
insert into temp_blocks values ('After every change on the cluster firewall, instruct the cluster to reload to the new rules via a `HUP` signal or by means of a `reload` command in `pg_ctl`.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Where is the host-based access firewall defined?');

insert into temp_blocks values ('select pg_reload_conf();', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Perform configuration reload on a cluster by means of an SQL statement?');

insert into temp_blocks values (
'<connection-type> <database>  <role> <remote-machine> <auth-method>
  local             all         all    all              scram-sha-256
  host              replication        samehost         md5
  hostssl           *                  samenet          reject
  nohostsll                            *                trust', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What is the structure of the host-based access file?');

insert into temp_blocks values ('Database will stop at first match.', 'text', 'txt');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'What is the priority of the hba rules?');

insert into temp_blocks values ('host forumdb brian all reject
host forumdb +group all scram-sha-256', 'code', 'conf');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Accept connections to a group of users except one of the members?');

insert into temp_blocks values ('host forumdb @rejected_users all reject
host forumdb @allowed_users all scram-sha-256', 'code', 'conf');
insert into temp_blocks values ('include_file, include_if_exists, include_dir', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Specify a file in hba rules?');

insert into temp_blocks values ('select line_number, type, database, user_name, address, auth_method from pg_hba_filel_rules;', 'code', 'sql');
call flashback.create_note('Learn PostgreSQL', 'Chapter 3', 'Inspect the hba rules of the cluster using SQL?);

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

