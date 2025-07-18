create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call set_section_as_complete('Linux Kernel Programming', 2);

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');
call add_block('text', 'txt', '');
call add_block('code', 'c',   '');
call add_block('code', 'sh',  '');
call create_note_with_name('Linux Kernel Programming', 4, '');

call set_section_as_complete('Linux Kernel Programming', 4);

drop procedure add_block;
drop table temp_blocks;
