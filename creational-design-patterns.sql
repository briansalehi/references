create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Creational Design Patterns in Modern C++', 2, '');

call set_section_as_complete('Creational Design Patterns in Modern C++', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Creational Design Patterns in Modern C++', 3, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 3);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Creational Design Patterns in Modern C++', 4, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 4);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Creational Design Patterns in Modern C++', 5, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Creational Design Patterns in Modern C++', 6, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Creational Design Patterns in Modern C++', 7, '');
--
--call set_section_as_complete('Creational Design Patterns in Modern C++', 7);

drop procedure add_block;
drop table temp_blocks;
