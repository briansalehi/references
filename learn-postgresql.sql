create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- joins

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 5, '');
--
--call set_section_as_complete('Learn PostgreSQL', 5);

-- advanced windows

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 6, '');
--
--call set_section_as_complete('Learn PostgreSQL', 6);

-- server-side programming

call add_block('text', 'txt', '* `true`: `yes`, `on`, 1
* `false`: `no`, `off`, 0');
call create_note_with_name('Learn PostgreSQL', 7, 'What forms of boolean types exist in postgres?');

call add_block('code', 'sql', 'alter table users add is_active boolean default true;');
call create_note_with_name('Learn PostgreSQL', 7, 'Add a boolean type column to a table?');

call add_block('code', 'sql', 'select 1.23456789::int4;');
call add_block('code', 'sql', 'select 1.23456789::int8;');
call add_block('text', 'txt', '* `integer`, `int4`
* `bigint`, `int8`');
call create_note_with_name('Learn PostgreSQL', 7, 'What are the two integral types in postgres?');

call add_block('code', 'sql', 'select 1.23456789::real;');
call add_block('code', 'sql', 'select 1.23456789::double precision;');
call add_block('text', 'txt', '* `real` (4 byte precision, almost 6 digits)
* `double precision` (8 byte variable precision, almost 15 digits)');
call create_note_with_name('Learn PostgreSQL', 7, 'What floating types are supported by postgres?');

call add_block('code', 'sql', 'select 1.99::numeric(3,2) as wallet;');
call add_block('text', 'txt', 'The type `numeric` takes two arguments `(precision, scale)`, by which precision is the total count of significant digits in the whole number, and the scale of a numeric is the count of decimal digits.');
call create_note_with_name('Learn PostgreSQL', 7, 'Write a numeric type to hold money amount?');

call add_block('code', 'sql', 'create table tags (id integer not null primary key, fixed_tag char(10), varying_tag varchar(10), long_tag text);');
call add_block('text', 'txt', '* `char(n)`, `character(n)`
* `varchar(n)`, `character varying(n)`
* `text`, `varchar`');
call create_note_with_name('Learn PostgreSQL', 7, 'What character types exist in postgres?');

call add_block('code', 'sql', 'select length(name) from users where id = 1;');
call create_note_with_name('Learn PostgreSQL', 7, 'Count the number of characters in a string?');

call add_block('code', 'sql', 'select octet_length(name) from users where id = 1;');
call create_note_with_name('Learn PostgreSQL', 7, 'Count the number of bytes in a string?');

call add_block('code', 'sql', '');
call add_block('text', 'txt', 'Using the `pg_settings` view, we can view the parameters set in the `postgresql.conf` configuration file.');
call create_note_with_name('Learn PostgreSQL', 7, 'Where in the database can we see the parameters in postgres configurations?');

call add_block('code', 'sql', 'select * from pg_settings where name = ''DateStyle'';');
call add_block('text', 'txt', '*postgresql.conf*

datestyle = ''iso, mdy''');
call create_note_with_name('Learn PostgreSQL', 7, 'Check the current date type of the server?');

call add_block('code', 'sql', 'select to_date(''2025-06-10'', ''yyyy-mm-dd'');');
call create_note_with_name('Learn PostgreSQL', 7, 'Convert a string to date type?');

call add_block('code', 'sql', 'select to_char(to_date(''2025-06-10'', ''yyyy-mm-dd''), ''dd.mm.yyyy'');');
call create_note_with_name('Learn PostgreSQL', 7, 'Convert a date type to string?');

call add_block('code', 'sql', 'create table posts (creation timestamp with timezone);');
call add_block('code', 'sql', 'select creation::timestamp with time zone as creation_tz, creation::timestamp without time zone as creation_nz from posts;');
call create_note_with_name('Learn PostgreSQL', 7, 'What are the two types of timestamps in postgres?');

call add_block('code', 'sql', 'show timezone;');
call create_note_with_name('Learn PostgreSQL', 7, 'Check the timezone set in current session?');

call add_block('code', 'sql', 'set timezone=''UTC'';');
call create_note_with_name('Learn PostgreSQL', 7, 'Change timezone in current session?');

call add_block('code', 'sql', 'select id, username, hstore(array[''first'', first_name, ''last'', last_name]) as name from users;');
call create_note_with_name('Learn PostgreSQL', 7, 'Create hstore rows in a query?');

call add_block('code', 'sql', 'select username from users where name->''first'' = ''Brian'';');
call create_note_with_name('Learn PostgreSQL', 7, 'Access to hstore data in a query?');

call add_block('code', 'sql', 'select row_to_json(q) as data from (select * from users) Q;');
call add_block('code', 'sql', 'create table posts (data jsonb);');
call add_block('code', 'sql', 'insert into posts (data) select row_to_json(q) from users;');
call create_note_with_name('Learn PostgreSQL', 7, 'Create JSON rows in a query?');

call add_block('code', 'sql', 'create table posts (data jsonb);');
call add_block('code', 'sql', 'select jsonb_pretty(data) from posts;');
call create_note_with_name('Learn PostgreSQL', 7, 'Beautify the JSON output in a query?');

call add_block('code', 'sql', 'select jsonb_pretty(data) from posts where data @> ''{"tag": "design"}'';');
call create_note_with_name('Learn PostgreSQL', 7, 'Search in a JSON data by matching to an object?');

call add_block('text', 'txt', '* SQL
* PL/pgSQL
* C');
call create_note_with_name('Learn PostgreSQL', 7, 'What builtin languages are supported by postgres?');

call add_block('code', 'sql', 'create or replace function show_timezone() returns varchar as begin return now(); end; language plpgsql;');
call create_note_with_name('Learn PostgreSQL', 7, 'Define a function?');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 7, '');

call set_section_as_complete('Learn PostgreSQL', 7);

 sequencial nodes

call add_block('text', 'txt', '* parsing
* rewriting
* optimization
* execution');
call create_note_with_name('Learn PostgreSQL', 13, 'What are the four stages of query execution?');

call add_block('text', 'txt', 'Handles the textual form of a statement and verifies whether it is syntactically correct or not.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is the responsibility of the parser?');

call add_block('text', 'txt', 'Applies any syntactic rules to rewrite the original statement into what will be effectively executed.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is the responsibility of the rewriter?');

call add_block('text', 'txt', 'Finds the fastest path to the data.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is the responsibility of the optimizer?');

call add_block('text', 'txt', 'Goes to the storage and retrieves the data using the access method decided by the executor.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is the responsibility of the executor?');

call add_block('text', 'txt', 'When retrieving a very large set of data that can be performed by dividing the amount of work between different parallel workers, each one assigned to a smaller subset of the data.');
call create_note_with_name('Learn PostgreSQL', 13, 'When does executor perform data access using parallel jobs?');

call add_block('text', 'txt', 'The optimizer divides the set of actions to pass to the executor in nodes. A node is an action to execute in order to provide the final or an intermediate result. For example, when executing a generic query asking for data in a specific order:');
call add_block('code', 'sql', 'select * from posts order by release_date;');
call add_block('text', 'txt', 'The optimizer will pass two actions to the executor, and thus the nodes include one to retrieve all the data and one to sort the data.');
call create_note_with_name('Learn PostgreSQL', 13, 'What is a node?');

call add_block('text', 'txt', '- Sequential nodes
- Parallel nodes');
call create_note_with_name('Learn PostgreSQL', 13, 'What nodes does the optimizer use?');

call add_block('text', 'txt', 'Sequential nodes are those nodes that will be executed sequentially, one afer the other, in order to achieve the final result.');
call add_block('text', 'txt', '- Sequential scan
- Index scan, index-only scan, and bitmap index scan
- Nested loop, hash join, and merge join
- The gather and merge parallel nodes');
call add_block('code', 'sql', '');
call create_note_with_name('Learn PostgreSQL', 13, 'What are the sequential nodes?');

call add_block('text', 'txt', 'The sequential scan is the only node that is always available to the optimizer and the executor, when there is no other valuable alternative. In sequential scan, the executor will iterate through all the data from the beginning of the dataset in sequential order.');
call add_block('text', 'txt', 'This node is used when the filtering clause is not very limiting in the query so that the end result will be to get almost the whole table contents.');
call add_block('code', 'sql', 'select * from categories;');
call create_note_with_name('Learn PostgreSQL', 13, 'When does the optimizer apply sequential scan?');

call add_block('text', 'txt', 'An index scan has access to the data that involves an index in order to quickly find the requested dataset. Indexes live alongside the table. Therefore, there will be a data file for the table and one for every index built on the table. Postgres avoids using indexes when double storage access accounts for more disadvantages than advantages. But when used, Postgres will produce an index node that can specialize in three different types:');
call add_block('text', 'txt', '- Index scan
- Index-only scan
- Bitmap index scan');
call create_note_with_name('Learn PostgreSQL', 13, 'What are the characteristics of index nodes?');

call add_block('text', 'txt', 'Using this classical index access method, Postgres reads the chosen index, and from that, it goes seeking the tuples, reading again from the storage.');
call create_note_with_name('Learn PostgreSQL', 13, 'How does index scan optimize queries?');

call add_block('text', 'txt', 'If the requested data only involves columns that belong to the index, Postgres is smart enough to avoid the second trip to storage.');
call create_note_with_name('Learn PostgreSQL', 13, 'How does index-only scan optimize queries?');

call add_block('text', 'txt', 'PostgreSQL builds a memory bitmap containing the location of tuples that satisfy the statement clauses, then it will use that bitmap to locate the tuples.');
call add_block('text', 'txt', 'Bitmap index scan is usually associated with bitmap heap scan.');
call create_note_with_name('Learn PostgreSQL', 13, 'How does bitmap index scan optimize queries?');

call add_block('text', 'txt', 'When PostgreSQL performs a join between two or more tables, it uses of the following nodes:');
call add_block('text', 'txt', '- Nested loop
- hash join
- merge join');
call create_note_with_name('Learn PostgreSQL', 13, 'What are the characteristics of join nodes?');

call add_block('text', 'txt', 'When bot both tables are scanned in a sequential or indexed based method and every tuple is checked to see whether there is a match.');
call add_block('code', 'c', 'for (tuple o: outer)
    for (tuple i: inner)
        if (o.matches(i))
            result_set.append(o, i);');
call add_block('text', 'txt', 'Nested loop nodes are not forced to perform a sequential scan on both tables. However, the core concept does not change that there will always be a nested doule loop to search for matches among the tuples.');
call add_block('text', 'txt', 'PostgreSQL chooses nested loop scans only if the inner table is small enough so that looping every time over it does not introduce any penalties.');
call create_note_with_name('Learn PostgreSQL', 13, 'When does the nested loop node applies by the optimizer?');

call add_block('text', 'txt', 'When the inner table is mapped into a hash, which is aset of buckets containing the tuples of the table, the outer table is then walked and for every tuple extraced from the outer table, the hash is searched to see whether there is a match.');
call add_block('code', 'c', 'hash inner_hash = build_hash(inner_table);

for (tuple o: outer_table)
    if (inner_hash.contains(build_hash(o));
        result_set.append(o, i);');
call create_note_with_name('Learn PostgreSQL', 13, 'When does the hash join node applies by the optimizer?');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call set_section_as_complete('Learn PostgreSQL', 13);

drop procedure add_block;
drop table temp_blocks;
