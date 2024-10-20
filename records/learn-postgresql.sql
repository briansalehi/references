create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call set_section_as_complete('Learn PostgreSQL', 1);

call add_block('code', 'sql', 'select current_database();');
call create_note_with_name('Learn PostgreSQL', 2, 'Query the name of current database?');

call add_block('code', 'sql', 'select current_date;');
call create_note_with_name('Learn PostgreSQL', 2, 'Query current date?');

call add_block('code', 'sql', 'select current_timestamp;');
call create_note_with_name('Learn PostgreSQL', 2, 'Query current date and time?');

call set_section_as_complete('Learn PostgreSQL', 2);

call add_block('code', 'sh', 'createuser');
call create_note_with_name('Learn PostgreSQL', 3, 'What command line utility creates user in a postgres instance?');

call add_block('code', 'sh', 'dropuser');
call create_note_with_name('Learn PostgreSQL', 3, 'What command line utility removes user in a postgres instance?');

call set_section_as_complete('Learn PostgreSQL', 3);

call set_section_as_complete('Learn PostgreSQL', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('text', 'txt', '');
--call create_note_with_name('Learn PostgreSQL', 5, '');

drop procedure add_block;
drop table temp_blocks;
