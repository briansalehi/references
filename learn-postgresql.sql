create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

-- advanced windows

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 6, '');

call set_section_as_complete('Learn PostgreSQL', 6);

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('text', 'txt', '');
call create_note_with_name('Learn PostgreSQL', 13, '');

call set_section_as_complete('Learn PostgreSQL', 13);

drop procedure add_block;
drop table temp_blocks;
