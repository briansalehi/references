create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 1, '');

call set_section_as_complete('Linux Kernel Debugging', 1);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 2, '');

call set_section_as_complete('Linux Kernel Debugging', 2);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 3, '');

call set_section_as_complete('Linux Kernel Debugging', 3);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 4, '');

call set_section_as_complete('Linux Kernel Debugging', 4);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 5, '');

call set_section_as_complete('Linux Kernel Debugging', 5);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 6, '');

call set_section_as_complete('Linux Kernel Debugging', 6);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 7, '');

call set_section_as_complete('Linux Kernel Debugging', 7);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 8, '');

call set_section_as_complete('Linux Kernel Debugging', 8);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 9, '');

call set_section_as_complete('Linux Kernel Debugging', 9);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 10, '');

call set_section_as_complete('Linux Kernel Debugging', 10);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 11, '');

call set_section_as_complete('Linux Kernel Debugging', 11);

call add_block('text', 'txt', '');
call add_block('code', 'c', '');
call create_note_with_name('Linux Kernel Debugging', 12, '');

call set_section_as_complete('Linux Kernel Debugging', 12);

drop procedure add_block;
drop table temp_blocks;
