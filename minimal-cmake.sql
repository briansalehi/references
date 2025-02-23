create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 6, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 7, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 8, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 9, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 10, '');

call add_block('text', 'txt', '');
call add_block('code', 'cmake', '');
call create_note_with_name('Minimal CMake', 11, '');

call set_section_as_complete('Minimal CMake', 6);
call set_section_as_complete('Minimal CMake', 7);
call set_section_as_complete('Minimal CMake', 8);
call set_section_as_complete('Minimal CMake', 9);
call set_section_as_complete('Minimal CMake', 10);
call set_section_as_complete('Minimal CMake', 11);

drop procedure add_block;
drop table temp_blocks;
