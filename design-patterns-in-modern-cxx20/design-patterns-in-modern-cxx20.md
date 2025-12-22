create temp table temp_blocks(row_number serial, t_content text, t_type milestone.block_type, t_language varchar(10));
create procedure add_block(type milestone.block_type, language varchar(10), content text) language plpgsql as $$ begin insert into temp_blocks (t_type, t_language, t_content) values (type, language, content); end; $$;

call add_block('text', 'txt', '');
call add_block('code', 'cpp', $$$$);
call create_note_with_name('Design Patterns in Modern C++20', 1, '');
call set_section_as_complete('Design Patterns in Modern C++20', 1);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 2, '');

--call set_section_as_complete('Design Patterns in Modern C++20', 2);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 3, '');

--call set_section_as_complete('Design Patterns in Modern C++20', 3);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 4, '');

--call set_section_as_complete('Design Patterns in Modern C++20', 4);

--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 5, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 5);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 6, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 6);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 7, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 7);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 8, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 8);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 9, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 9);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 10, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 10);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 11, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 11);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 12, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 12);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 13, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 13);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 14, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 14);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 15, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 15);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 16, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 16);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 17, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 17);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 18, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 18);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 19, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 19);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 20, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 20);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 21, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 21);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 22, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 22);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 23, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 23);
--
--call add_block('text', 'txt', '');
--call add_block('code', 'cpp', $$$$);
--call create_note_with_name('Design Patterns in Modern C++20', 24, '');
--
--call set_section_as_complete('Design Patterns in Modern C++20', 24);

drop procedure add_block;
drop table temp_blocks;# Subject
# Resource
## Resource Type (book, website, course, video, channel, mailing list, manual, slides)
## Provider
### Section Pattern (chapter, page, course, video, post)
### Presenter

#### Topic Level (surface, depth, origin)
#### Topic

##### Section

###### Card
