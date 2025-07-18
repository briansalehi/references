create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Behavioral Design Patterns in C++', 5, '');

call set_section_as_complete('Behavioral Design Patterns in C++', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 6, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 7, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 8, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 9, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 10, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 11, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 12, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Behavioral Design Patterns in C++', 13, '');
--
--call set_section_as_complete('Behavioral Design Patterns in C++', 13);

drop procedure add_block;
drop table temp_blocks;
