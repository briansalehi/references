create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('code', 'sql', 'select * from users where age > 18 and age < 35;');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter the resultset by arithmetic conditions?');

call add_block('code', 'sql', 'select * from products where name like ''%Laptop%'';');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter the resultset to only records with a substring?');

call add_block('code', 'sql', 'select * from products where upper(name) like ''%LAPTOP%'';');
call add_block('code', 'sql', 'select * from products where name ilike ''%Laptop%'';');
call create_note_with_name('Learn PostgreSQL', 5, 'Use case-insensitive filtering to match a substring?');

call add_block('code', 'sql', 'select coalesce(profile_picture, ''profile.png'') from users;');
call create_note_with_name('Learn PostgreSQL', 5, 'Use a function to return the non-null value?');

call add_block('code', 'sql', '\pset null (NULL);');
call create_note_with_name('Learn PostgreSQL', 5, 'Change the null presentation in queries?');

call add_block('code', 'sql', 'select coalesce(profile_picture, ''profile.png'') as profile_picture from users;');
call create_note_with_name('Learn PostgreSQL', 5, 'Use a descriptive name for columns resulting of function calls?');

call add_block('code', 'sql', 'select distinct name from users;');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter out the duplicate results from a resultset?');

call add_block('code', 'sql', 'select * from users limit 10;');
call create_note_with_name('Learn PostgreSQL', 5, 'Limit the number of query results to specific rows?');

call add_block('code', 'sql', 'select * from users offset 20 limit 5;');
call create_note_with_name('Learn PostgreSQL', 5, 'Limit the query results to a number of rows somewhere in the middle?');

call add_block('code', 'sql', 'create table banned_users as select * from users limit 0;');
call create_note_with_name('Learn PostgreSQL', 5, 'Duplicate a table structure without copying rows?');

call add_block('code', 'sql', 'select * from users where role in (''manager'', ''team manager'');');
call add_block('code', 'sql', 'select * from users where role not in (''manager'', ''team manager'');');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter query results by limiting a column only to a subset of values?');

call add_block('code', 'sql', 'select * from users where nationality in (select id from countries where region = ''Europe'');');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter query results by matching a subquery?');

call add_block('code', 'sql', 'select * from users where exists (select 1 from comments where user_id = users.id);');
call add_block('code', 'sql', 'select * from users where not exists (select 1 from comments where user_id = users.id);');
call create_note_with_name('Learn PostgreSQL', 5, 'Filter query results by checking the existance of a subquery?');

-- joins

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 5, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 5, '');
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 5, '');
--
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

-- sequencial nodes

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 13, '');
--
--call set_section_as_complete('Learn PostgreSQL', 13);

drop procedure add_block;
drop table temp_blocks;
