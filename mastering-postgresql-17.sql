create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call add_block('text', 'txt', '');
call add_block('code', 'sql', '');
call add_block('code', 'sh', '');
call create_note_with_name('Mastering PostgreSQL 17', 1, '');

call set_section_as_complete('Mastering PostgreSQL 17', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 2, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 3, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 4, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 5, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 6, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 7, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 8, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 9, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 10, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 11, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 12, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'sql', '');
--call add_block('code', 'sh', '');
--call create_note_with_name('Mastering PostgreSQL 17', 13, '');
--call set_section_as_complete('Mastering PostgreSQL 17', 13);

drop procedure add_block;
drop table temp_blocks;
