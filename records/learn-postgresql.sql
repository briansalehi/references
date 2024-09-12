create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure flashback.add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql as $$ begin insert into temp_blocks (t_content, t_type, t_language) values (content, type, language); end; $$;

call flashback.add_block('`postgres` user is default admin in postgres.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What user is created on postgres by default?');

call flashback.add_block('A role can be a single account, or a group representing a collection of database permissions and connection properties.', 'text', 'txt');
call flashback.add_block('Every role must have a unique username.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What is a role?');

call flashback.add_block('A role is defined at the cluster level, while permissions are defined at the database level.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What is the difference between roles and permissions scopes?');

call flashback.add_block('create role <name> with password ''secret'' login;', 'code', 'sql');
call flashback.add_block('The default option is `NOLOGIN`. Therefore, in order to define interactive users, remember to add the `LOGIN` option when creating a role.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Create a new role having privileges to login in to the cluter?');

call flashback.add_block('Almost every option of the `create role` statement has a positive form that adds the ability to the role, and a negative form with `NO` prefix that excludes the ability from the role.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What are the general forms of role creation options?');

call flashback.add_block('create role <user> with password ''secret'' superuser login;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Create a role with superuser privileges?');

call flashback.add_block('create role <user> with password null;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Create a role without a password?');

call flashback.add_block('create role <user> with password ''secret'' login connection limit 1;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Limit the number of connections a role can make to the cluster?');

call flashback.add_block('create role <user> with password ''secret'' login valid until ''2026-12-31'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Create a role that will be expired within a year?');

call flashback.add_block('A group is a role that contains other roles.', 'text', 'txt');
call flashback.add_block('To create a group simply create a role without a login capability.', 'text', 'txt');
call flashback.add_block('create role <group> with nologin;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Create a group?');

call flashback.add_block('create role <user> with login password ''secret'' in role <group> connection limit 1 valid until ''2026-12-31'';', 'code', 'sql');
call flashback.add_block('The `in group` clause of `create role` is an absolute synonym for the `in role` clause.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Join a role into a group when creating one?');

call flashback.add_block('grant <group> to <user>;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Join a role into a group after its creation?');

call flashback.add_block('create role <group> with nologin admin <user>;', 'code', 'sql');
call flashback.add_block('The <user>, even if not a cluster superuser, will be able to add new members to the <group>.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Specify an admin for a group when creating one?');

call flashback.add_block('grant <group> to <user> with admin option;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Specify an admin for a group after its creation?');

call flashback.add_block('drop role if exists <user>;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Remove a role?');

call flashback.add_block('select current_role;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Inspect current role?');

call flashback.add_block('\du', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Get a list of all available roles in the cluster?');

call flashback.add_block('\drg', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'List the groups a role is a member of?');

call flashback.add_block('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_roles where rolname = ''user'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Get a user information from roles catalog?');

call flashback.add_block('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_authid where rolname = ''user'';', 'code', 'sql');
call flashback.add_block('The catalog `pg_roles` can be queried by either superuser or normal users, but `pg_authid` can only be queried by superuser.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Get sensitive information of roles in the cluster?');

call flashback.add_block('`$PGDATA/pg_hba.conf`', 'text', 'txt');
call flashback.add_block('After every change on the cluster firewall, instruct the cluster to reload to the new rules via a `HUP` signal or by means of a `reload` command in `pg_ctl`.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Where is the host-based access firewall defined?');

call flashback.add_block('select pg_reload_conf();', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Perform configuration reload on a cluster by means of an SQL statement?');

call flashback.add_block(
'<connection-type> <database>  <role> <remote-machine> <auth-method>
  local             all         all    all              scram-sha-256
  host              replication        samehost         md5
  hostssl           *                  samenet          reject
  nohostsll                            *                trust', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What is the structure of the host-based access file?');

call flashback.add_block('Database will stop at first match.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'What is the priority of the hba rules?');

call flashback.add_block('host forumdb brian all reject
host forumdb +group all scram-sha-256', 'code', 'conf');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Accept connections to a group of users except one of the members?');

call flashback.add_block('host forumdb @rejected_users all reject
host forumdb @allowed_users all scram-sha-256', 'code', 'conf');
call flashback.add_block('include_file, include_if_exists, include_dir', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Specify a file in hba rules?');

call flashback.add_block('select line_number, type, database, user_name, address, auth_method from pg_hba_filel_rules;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 3, 'Inspect the hba rules of the cluster using SQL?');

call flashback.add_block('**Data Definition Language (DDL)** commands are used to manage databases and tables.', 'text', 'txt');
call flashback.add_block('**Data Manipulation Language (DML)** commands are used to insert, delete, update and select data inside databases. ', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'What type of commands exist in database?');

call flashback.add_block('psql -U <username> -h <hostname> -d <database>', 'code', 'sh');
call flashback.add_block('psql -U postgres -h localhost -d template1', 'code', 'sh');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Connect to a postgres instance?');

call flashback.add_block('\x', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Switch postgres to expanded mode?');

call flashback.add_block('\l', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'List databases present in the cluster?');

call flashback.add_block('\c <database>', 'code', 'sql');
call flashback.add_block('\c postgres', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Connect to a database in psql?');

call flashback.add_block('create database <database>', 'code', 'sql');
call flashback.add_block('create database sample', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Create a new database?');

call flashback.add_block('`template1`', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'What database is used to clone as new ones?');

call flashback.add_block('`template0` is a read-only backup in case `template1` is accidentally removed.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Why is there two template databases?');

call flashback.add_block('Databases can be organized by namespaces called schema.', 'text', 'txt');
call flashback.add_block('Schemas cannot be nested, and they represent a flat namespace.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'What is a schema?');

call flashback.add_block('A normal user cannot perform DDL on the public schema.', 'text', 'txt');
call flashback.add_block('A normal user cannot perform DML on the public schema unless superuser allows that.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'What schema can be used by a normal user?');

call flashback.add_block('Contains the sequence of schemas that postgres uses to find tables.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'What is the <code>search_path</code> variable?');

call flashback.add_block('create database sample;
\c sample
create user first_user with password "complex password" login;
create schema sample_uexamples', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Allow a user to create database objects in a custom schema?');

call flashback.add_block('\dt', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'List all available databases?');

call flashback.add_block('create database project template project_defaults;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Create a database from a user defined template?');

call flashback.add_block('drop database projects;', 'code', 'sql');
call flashback.add_block('When there are dependencies to the database, this action can cascade to all of them too.', 'text', 'txt');
call flashback.add_block('drop database projects cascade;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Drop a database?');

call flashback.add_block('drop table users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Drop a table from a database?');

call flashback.add_block('\l+ project', 'code', 'sql');
call flashback.add_block('select pg_database_size(''project'');', 'code', 'sql');
call flashback.add_block('select pg_size_pretty(pg_database_size(''project''));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Get the size of a database?');

call flashback.add_block('select * from pg_database where datname = ''project'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Find the Object ID of a database on storage?');

call flashback.add_block('create table users ( id int generated always as identity, username varchar(40) not null, primary key(id), unique(username));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Create a table?');

call flashback.add_block('create table if not exists users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Create a table only when it doesn''t already exist?');

call flashback.add_block('1. Logged Tables: these are the regular tables we create.', 'text', 'txt');
call flashback.add_block('create table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call flashback.add_block('2. Unlogged Tables: faster than regular tables but they are not crash-safe..', 'text', 'txt');
call flashback.add_block('create unlogged table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call flashback.add_block('3. Temporary Tables: mostly used in transactions for isolation and is only visible to the session where it was created.', 'text', 'txt');
call flashback.add_block('create temp table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'How many table types exist?');

call flashback.add_block('First, create a session. Then create the temp table. And finally, commit or roll back the transaction.', 'text', 'txt');
call flashback.add_block('begin work;
create temp table sample (id int generated always as identity, primary key (id)) on commit drop;
commit work;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'How temp tables can be dropped automatically?');

call flashback.add_block('select oid, relanem from pg_class where relname = ''users'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Get the object ID of a table on storage?');

call flashback.add_block('It is possible to insert one or more rows specified by value expressions, or zero or more rows resulting from a query.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'How many ways are possible to insert into data a table?');

call flashback.add_block('insert into users (username) values (''user1'');', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Insert data into a table with value expressions?');

call flashback.add_block('select * from users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Select data from a table out of order?');

call flashback.add_block('select * from users order by joined;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Order the output of a select query?');

call flashback.add_block('insert into users (username) values (''user1''), (''user2'');', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Insert multiple rows into a table in one insertion?');

call flashback.add_block('select * from users where joined between ''2024-08-01'' and ''2026-08-01'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Filter select query results?');

call flashback.add_block('1. Asending `asc` which is the default when not specified.
2. Desending: `desc`.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'How many ordering directions exist?');

call flashback.add_block('select * from users order by 2, 3;', 'code', 'sql');
call flashback.add_block('select * from users order by name, age;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 4, 'Write an order by clause with column positions?');

call flashback.add_block('', 'text', 'txt');
call flashback.add_block('', 'code', 'sql');
call flashback.add_block('', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 4, '');
