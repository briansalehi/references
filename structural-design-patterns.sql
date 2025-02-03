create temp table temp_blocks(row_number serial, t_content text, t_type flashback.block_type, t_language varchar(10));
create procedure add_block(type flashback.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call create_resource(6, 'Structural Design Patterns in C++', 'video', 1, 8, 'https://subscription.packtpub.com/video/programming/9781801073073');

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Structural Design Patterns in C++', 1, '');

call set_section_as_complete('Structural Design Patterns in C++', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 2, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 2);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 3, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 4, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 5, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 6, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 7, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Structural Design Patterns in C++', 8, '');
--
--call set_section_as_complete('Structural Design Patterns in C++', 8);

drop procedure add_block;
drop table temp_blocks;
