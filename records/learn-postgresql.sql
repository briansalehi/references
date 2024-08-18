create temp table if not exists temp_blocks (row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
delete from temp_blocks;

create or replace procedure add_block(content text, type flashback.block_type, language varchar(10))
language plpgsql
as $$
begin
    insert into temp_blocks (t_content, t_type, t_language) values (content, type, language);
end;
$$;

call add_block('`postgres` user is default admin in postgres.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What user is created on postgres by default?');

call add_block('A role can be a single account, or a group representing a collection of database permissions and connection properties.', 'text', 'txt');
call add_block('Every role must have a unique username.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What is a role?');

call add_block('A role is defined at the cluster level, while permissions are defined at the database level.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What is the difference between roles and permissions scopes?');

call add_block('create role <name> with password ''secret'' login;', 'code', 'sql');
call add_block('The default option is `NOLOGIN`. Therefore, in order to define interactive users, remember to add the `LOGIN` option when creating a role.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Create a new role having privileges to login in to the cluter?');

call add_block('Almost every option of the `create role` statement has a positive form that adds the ability to the role, and a negative form with `NO` prefix that excludes the ability from the role.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What are the general forms of role creation options?');

call add_block('create role <user> with password ''secret'' superuser login;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Create a role with superuser privileges?');

call add_block('create role <user> with password null;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Create a role without a password?');

call add_block('create role <user> with password ''secret'' login connection limit 1;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Limit the number of connections a role can make to the cluster?');

call add_block('create role <user> with password ''secret'' login valid until ''2026-12-31'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Create a role that will be expired within a year?');

call add_block('A group is a role that contains other roles.', 'text', 'txt');
call add_block('To create a group simply create a role without a login capability.', 'text', 'txt');
call add_block('create role <group> with nologin;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Create a group?');

call add_block('create role <user> with login password ''secret'' in role <group> connection limit 1 valid until ''2026-12-31'';', 'code', 'sql');
call add_block('The `in group` clause of `create role` is an absolute synonym for the `in role` clause.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Join a role into a group when creating one?');

call add_block('grant <group> to <user>;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Join a role into a group after its creation?');

call add_block('create role <group> with nologin admin <user>;', 'code', 'sql');
call add_block('The <user>, even if not a cluster superuser, will be able to add new members to the <group>.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Specify an admin for a group when creating one?');

call add_block('grant <group> to <user> with admin option;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Specify an admin for a group after its creation?');

call add_block('drop role if exists <user>;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Remove a role?');

call add_block('select current_role;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Inspect current role?');

call add_block('\du', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Get a list of all available roles in the cluster?');

call add_block('\drg', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'List the groups a role is a member of?');

call add_block('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_roles where rolname = ''user'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Get a user information from roles catalog?');

call add_block('select rolname, rolcanlogin, rolconnlimit, rolpassword from pg_authid where rolname = ''user'';', 'code', 'sql');
call add_block('The catalog `pg_roles` can be queried by either superuser or normal users, but `pg_authid` can only be queried by superuser.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Get sensitive information of roles in the cluster?');

call add_block('`$PGDATA/pg_hba.conf`', 'text', 'txt');
call add_block('After every change on the cluster firewall, instruct the cluster to reload to the new rules via a `HUP` signal or by means of a `reload` command in `pg_ctl`.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Where is the host-based access firewall defined?');

call add_block('select pg_reload_conf();', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Perform configuration reload on a cluster by means of an SQL statement?');

call add_block(
'<connection-type> <database>  <role> <remote-machine> <auth-method>
  local             all         all    all              scram-sha-256
  host              replication        samehost         md5
  hostssl           *                  samenet          reject
  nohostsll                            *                trust', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What is the structure of the host-based access file?');

call add_block('Database will stop at first match.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'What is the priority of the hba rules?');

call add_block('host forumdb brian all reject
host forumdb +group all scram-sha-256', 'code', 'conf');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Accept connections to a group of users except one of the members?');

call add_block('host forumdb @rejected_users all reject
host forumdb @allowed_users all scram-sha-256', 'code', 'conf');
call add_block('include_file, include_if_exists, include_dir', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Specify a file in hba rules?');

call add_block('select line_number, type, database, user_name, address, auth_method from pg_hba_filel_rules;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 3', 'Inspect the hba rules of the cluster using SQL?');

call add_block('**Data Definition Language (DDL)** commands are used to manage databases and tables.', 'text', 'txt');
call add_block('**Data Manipulation Language (DML)** commands are used to insert, delete, update and select data inside databases. ', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What type of commands exist in database?');

call add_block('psql -U <username> -h <hostname> -d <database>', 'code', 'sh'), ('psql -U postgres -h localhost -d template1', 'code', 'sh');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Connect to a postgres instance?');

call add_block('\x', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Switch postgres to expanded mode?');

call add_block('\l', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'List databases present in the cluster?');

call add_block('\c <database>', 'code', 'sql');
call add_block('\c postgres', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Connect to a database in psql?');

call add_block('create database <database>', 'code', 'sql');
call add_block('create database sample', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Create a new database?');

call add_block('`template1`', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What database is used to clone as new ones?');

call add_block('`template0` is a read-only backup in case `template1` is accidentally removed.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Why is there two template databases?');

call add_block('Databases can be organized by namespaces called schema.', 'text', 'txt');
call add_block('Schemas cannot be nested, and they represent a flat namespace.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What is a schema?');

call add_block('A normal user cannot perform DDL on the public schema.', 'text', 'txt');
call add_block('A normal user cannot perform DML on the public schema unless superuser allows that.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What schema can be used by a normal user?');

call add_block('Contains the sequence of schemas that postgres uses to find tables.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What is the <code>search_path</code> variable?');

call add_block('create database sample;
\c sample
create user first_user with password "complex password" login;
create schema sample_uexamples', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Allow a user to create database objects in a custom schema?');

call add_block('\dt', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'List all available databases?');

call add_block('create database project template project_defaults;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Create a database from a user defined template?');

call add_block('drop database projects;', 'code', 'sql');
call add_block('When there are dependencies to the database, this action can cascade to all of them too.', 'text', 'txt');
call add_block('drop database projects cascade;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Drop a database?');

call add_block('drop table users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Drop a table from a database?');

call add_block('\l+ project', 'code', 'sql');
call add_block('select pg_database_size(''project'');', 'code', 'sql');
call add_block('select pg_size_pretty(pg_database_size(''project''));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Get the size of a database?');

call add_block('select * from pg_database where datname = ''project'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Find the Object ID of a database on storage?');

call add_block('create table users ( id int generated always as identity, username varchar(40) not null, primary key(id), unique(username));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Create a table?');

call add_block('create table if not exists users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Create a table only when it doesn''t already exist?');

call add_block('1. Logged Tables: these are the regular tables we create.', 'text', 'txt');
call add_block('create table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call add_block('2. Unlogged Tables: faster than regular tables but they are not crash-safe..', 'text', 'txt');
call add_block('create unlogged table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call add_block('3. Temporary Tables: mostly used in transactions for isolation and is only visible to the session where it was created.', 'text', 'txt');
call add_block('create temp table sample (id int generated always as identity, primary key (id));', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'How many table types exist?');

call add_block('First, create a session. Then create the temp table. And finally, commit or roll back the transaction.', 'text', 'txt');
call add_block('begin work;
create temp table sample (id int generated always as identity, primary key (id)) on commit drop;
commit work;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'How temp tables can be dropped automatically?');

call add_block('select oid, relanem from pg_class where relname = ''users'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Get the object ID of a table on storage?');

call add_block('It is possible to insert one or more rows specified by value expressions, or zero or more rows resulting from a query.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'How many ways are possible to insert into data a table?');

call add_block('insert into users (username) values (''user1'');', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Insert data into a table with value expressions?');

call add_block('select * from users;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Select data from a table out of order?');

call add_block('select * from users order by joined;', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Order the output of a select query?');

call add_block('insert into users (username) values (''user1''), (''user2'');', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Insert multiple rows into a table in one insertion?');

call add_block('select * from users where joined between ''2024-08-01'' and ''2026-08-01'';', 'code', 'sql');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'Filter select query results?');

call add_block('1. Asending `asc` which is the default when not specified.
2. Desending: `desc`.', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'How many ordering directions exist?');

call add_block('', 'code', 'sql');
call add_block('', 'text', 'txt');
call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', 'What variations of writing order by clause exist?');

--call add_block('', 'code', 'sql');
--call add_block('', 'text', 'txt');
--call flashback.create_note_with_name('Learn PostgreSQL', 'Chapter 4', '');
